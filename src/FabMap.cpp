#include "FabMap.h"

#include <fstream>
#include <opencv2/core/core.hpp>
#include <opencv2/nonfree/features2d.hpp>

namespace slam
{

FabMap::FabMap()
{
	valid = false;

	std::string packagePath = "/home/michele/Documents/master thesis/softwares/workspace/use_fabmap/";

    // These is an included trained vocabulary
	//std::string fabmapTrainDataPath = packagePath + "openfabmap/trainingdata/StLuciaShortTraindata.yml";
	//std::string vocabPath = packagePath + "openfabmap/trainingdata/StLuciaShortVocabulary.yml";
	//std::string chowliutreePath = packagePath + "openfabmap/trainingdata/StLuciaShortTree.yml";
	//std::string resultsPath = packagePath + "results";

	//std::string fabmapTrainDataPath = "/home/michele/Documents/master thesis/softwares/openFABMAPsample/new_college/train_data.yml";
	//std::string vocabPath = "/home/michele/Documents/master thesis/softwares/openFABMAPsample/new_college/vocab.yml";
	//std::string chowliutreePath = "/home/michele/Documents/master thesis/softwares/openFABMAPsample/new_college/tree.yml";
	//std::string resultsPath = packagePath + "results";

	//std::string fabmapTrainDataPath = "/home/michele/Documents/master thesis/softwares/openFABMAPsample/train_data.yml";
	//std::string vocabPath = "/home/michele/Documents/master thesis/softwares/openFABMAPsample/vocab.yml";
	//std::string chowliutreePath = "/home/michele/Documents/master thesis/softwares/openFABMAPsample/tree.yml";;
	//std::string resultsPath = packagePath + "results";
	
	std::string fabmapTrainDataPath = "/home/michele/Documents/master thesis/softwares/openFABMAPsample/Nantes/normal_voc_0_55/train_data.yml";
	std::string vocabPath = "/home/michele/Documents/master thesis/softwares/openFABMAPsample/Nantes/normal_voc_0_55/vocab.yml";
	std::string chowliutreePath = "/home/michele/Documents/master thesis/softwares/openFABMAPsample/Nantes/normal_voc_0_55/tree.yml";
	std::string resultsPath = packagePath + "results";

	// Load training data
	cv::FileStorage fsTraining;
	fsTraining.open(fabmapTrainDataPath, cv::FileStorage::READ);
	cv::Mat fabmapTrainData;
	fsTraining["BOWImageDescs"] >> fabmapTrainData;
	if (fabmapTrainData.empty()) {
		std::cerr << fabmapTrainDataPath << ": FabMap Training Data not found" << std::endl;
		return;
	}
	fsTraining.release();

	// Load vocabulary
	cv::FileStorage fsVocabulary;
	fsVocabulary.open(vocabPath, cv::FileStorage::READ);
	cv::Mat vocabulary;
	fsVocabulary["Vocabulary"] >> vocabulary;
	if (vocabulary.empty()) {
		std::cerr << vocabPath << ": Vocabulary not found" << std::endl;
		return;
	}
	fsVocabulary.release();

	//load a chow-liu tree
	cv::FileStorage fsTree;
	fsTree.open(chowliutreePath, cv::FileStorage::READ);
	cv::Mat clTree;
	fsTree["ChowLiuTree"] >> clTree;
	if (clTree.empty()) {
		std::cerr << chowliutreePath << ": Chow-Liu tree not found" << std::endl;
		return;
	}
	fsTree.release();


	// ############################################################################# !!!!!!!!!!!!!!!!
	// Generate openFabMap object (FabMap2 - needs training bow data!)
	int options = 0;
	options |= of2::FabMap::SAMPLED;
	options |= of2::FabMap::CHOW_LIU;
	fabMap = new of2::FabMap2(clTree, 0.39, 0, options);            // set 0.39 as false positive rate !!!!!!!!!!!!
	//add the training data for use with the sampling method
	fabMap->addTraining(fabmapTrainData);

	// 	// Generate openFabMap object (FabMap1 with look up table)
	// 	int options = 0;
	// 	options |= of2::FabMap::MEAN_FIELD;
	// 	options |= of2::FabMap::CHOW_LIU;
	// 	//fabMap = new of2::FabMap(clTree, 0.39, 0, options);
	// 	fabMap = new of2::FabMapLUT(clTree, 0.39, 0, options, 3000, 6);
	// 	//fabMap = new of2::FabMapFBO(clTree, 0.39, 0, options, 3000, 1e-6, 1e-6, 512, 9);

	// Create detector & extractor
	detector = new cv::StarFeatureDetector(32, 10, 18, 18, 20);
	cv::Ptr<cv::DescriptorExtractor> extractor = new cv::SURF(1000, 4, 2, false, true); // new cv::SIFT();

	//use a FLANN matcher to generate bag-of-words representations
	cv::Ptr<cv::DescriptorMatcher> matcher = cv::DescriptorMatcher::create("FlannBased"); // alternative: "BruteForce"
	bide = new cv::BOWImgDescriptorExtractor(extractor, matcher);
	bide->setVocabulary(vocabulary);

	confusionMat = cv::Mat(0, 0, CV_32F);

	nextImageID = 0;
	valid = true;
}

FabMap::~FabMap()
{
	std::string packagePath = "/home/michele/Documents/master thesis/softwares/workspace/use_fabmap/";
	std::string resultsPath = packagePath + "results";

	if (printConfusionMatrix)
	{
		std::ofstream writer((resultsPath + "fabMapResult.txt").c_str());
		for(int i = 0; i < confusionMat.rows; i++) {
			for(int j = 0; j < confusionMat.cols; j++) {
				writer << confusionMat.at<float>(i, j) << " ";
			}
			writer << std::endl;
		}
		writer.close();
	}
}


/* Version of compareAndAdd in which targetROI2 is passed in order to plot
 * the features detected on the image
 */
double FabMap::compareAndAdd(cv::Mat frame, int* out_newID, int* out_loopID, cv::Mat targetROI)
{
	// Convert keyframe image data to 3-channel OpenCV Mat (theoretically unneccessary)
	// cv::Mat frame;
	// cv::Mat keyFrameImage(keyframe->height(), keyframe->width(), CV_32F, const_cast<float*>(keyframe->image()));
	// keyFrameImage.convertTo(frame, CV_8UC1);
	//cv::cvtColor(frame, frame, CV_GRAY2RGB);

	// Generate FabMap bag-of-words data (image descriptor)
	cv::Mat bow, kptsImg;
	std::vector<cv::KeyPoint> kpts;
	detector->detect(frame, kpts);            // detector of keypoints
	if (kpts.empty())
	{
		std::cout << "No keypoints detected!!!!" << std::endl;
		*out_newID = -1;
		*out_loopID = -1;
		return 0;
	}

	cv::drawKeypoints(frame, kpts, kptsImg);
	// drawRichKeypoints(frame, kpts, kptsImg);

	kptsImg.copyTo(targetROI);

	bide->compute(frame, kpts, bow);          // compute the descriptor (in terms of the dictionary)

	// Run FabMap
	std::vector<of2::IMatch> matches;
	if (nextImageID > 0)
		fabMap->compare(bow, matches);         // matching !!!!!!
	fabMap->add(bow);                          // add the descriptors
	*out_newID = nextImageID;
	++nextImageID;

	if (printConfusionMatrix)
	{
		cv::Mat resizedMat(nextImageID, nextImageID, confusionMat.type(), cv::Scalar(0));
		if (confusionMat.rows > 0)
			confusionMat.copyTo(resizedMat(cv::Rect(cv::Point(0, 0), confusionMat.size())));
		confusionMat = resizedMat;

		for(auto l = matches.begin(); l != matches.end(); ++ l)
		{
			int col = (l->imgIdx < 0) ? (nextImageID-1) : l->imgIdx;
			confusionMat.at<float>(nextImageID-1, col) = l->match;
		}
	}


	float accumulatedProbability = 0;
	int flag = 0;      // variable set by me to say if we have a match or not!!!
	double most_likely_place_prob = 0;


	// #################### IMPORTANT  !!!!!!!!!!!!  #########################
	const bool debugProbabilites = false;
	int counter = 0;

	if (debugProbabilites){
		printf("Current image number: %d \n", *out_newID);
		printf("FabMap probabilities: \n");
	}


	for( auto l = matches.begin(); l != matches.end(); ++l )
	{
		counter++;

		if (debugProbabilites){
			if(l->match >= 0.1){
				printf(" (%i: %f) ", l->imgIdx, l->match);
			}
			// std::cout << "Current processed image: " << *out_newID << std::endl;
		}

		// Probability for existing place
		if (l->match >= minLoopProbability && abs( *out_newID - counter - 2 ) >= tolerance && l->match >= most_likely_place_prob)
		{
			*out_loopID = l->imgIdx;      // if a loop closure is detected
			
			if (debugProbabilites){
				std::cout << std::endl << "Match!!!"  << l->match << std::endl;
				printf("\n");
			}
			most_likely_place_prob = l->match;
			flag = 1;
		}

		if ( !debugProbabilites && accumulatedProbability > 1 - minLoopProbability)
		{
			std::cout << "Debug break!!!!!" << std::endl;
			break; // not possible anymore to find a frame with high enough probability
		}


	}


	if (debugProbabilites)
		printf("\n");

	if(flag){
		return most_likely_place_prob;
	}
	else {
		*out_loopID = -1;			// important !!!!!!!!
	}

	return 0;
}


/* First version of compareAndAdd
 * 
 */

void FabMap::compareAndAdd(cv::Mat frame, int* out_newID, int* out_loopID)
{
	// Convert keyframe image data to 3-channel OpenCV Mat (theoretically unneccessary)
	// cv::Mat frame;
	// cv::Mat keyFrameImage(keyframe->height(), keyframe->width(), CV_32F, const_cast<float*>(keyframe->image()));
	// keyFrameImage.convertTo(frame, CV_8UC1);
	//cv::cvtColor(frame, frame, CV_GRAY2RGB);

	// Generate FabMap bag-of-words data (image descriptor)
	cv::Mat bow;
	std::vector<cv::KeyPoint> kpts;
	detector->detect(frame, kpts);            // detector of keypoints
	if (kpts.empty())
	{
		std::cout << "No keypoints detected!!!!" << std::endl;
		*out_newID = -1;
		*out_loopID = -1;
		return;
	}
	bide->compute(frame, kpts, bow);          // compute the descriptor (in terms of the dictionary)

	// Run FabMap
	std::vector<of2::IMatch> matches;
	if (nextImageID > 0)
		fabMap->compare(bow, matches);         // matching !!!!!!
	fabMap->add(bow);                          // add the descriptors
	*out_newID = nextImageID;
	++nextImageID;

	if (printConfusionMatrix)
	{
		cv::Mat resizedMat(nextImageID, nextImageID, confusionMat.type(), cv::Scalar(0));       // dynamically increment the size of the confusion matrix
		if (confusionMat.rows > 0)
			confusionMat.copyTo(resizedMat(cv::Rect(cv::Point(0, 0), confusionMat.size())));
		confusionMat = resizedMat;

		for(auto l = matches.begin(); l != matches.end(); ++ l)
		{
			int col = (l->imgIdx < 0) ? (nextImageID-1) : l->imgIdx;        // add to the diagonal as a new place or to and already visited location
			confusionMat.at<float>(nextImageID-1, col) = l->match;          // append the probability of the match
		}
	}

	float accumulatedProbability = 0;

	// #################### IMPORTANT  !!!!!!!!!!!!#########################
	const bool debugProbabilites = true;
	int counter = 0;

	if (debugProbabilites){
		printf("Current image number: %d \n", *out_newID);
		printf("FabMap probabilities: \n");
	}

	for( auto l = matches.begin(); l != matches.end(); ++l )
	{
		counter++;

		if (debugProbabilites){
			if(l->match >= 0.1){
				printf(" (%i: %f) ", l->imgIdx, l->match);
			}
			// std::cout << "Current processed image: " << *out_newID << std::endl;
		}

		if(l->imgIdx < 0)
		{
			// Probability for new place:  index = -1
			accumulatedProbability += l->match;
			// std::cout << "New place probability!" << std::endl;
		}
		else
		{
			// Probability for existing place
			if (l->match >= minLoopProbability && abs( *out_newID - counter - 2 ) >= tolerance)
			{
				*out_loopID = l->imgIdx;      // if a loop closure is detected
				if (debugProbabilites){
					std::cout << std::endl << "Match!!! Prob = "  << l->match << std::endl;
					printf("\n");
				}
				return;
			}
			accumulatedProbability += l->match;
		}

		if ( !debugProbabilites && accumulatedProbability > 1 - minLoopProbability)
		{
			std::cout << "Debug break!!!!!" << std::endl;
			break; // not possible anymore to find a frame with high enough probability
		}
	}
	if (debugProbabilites)
		printf("\n");

	*out_loopID = -1;			// important !!!!!!!!
	return;
}


bool FabMap::isValid() const
{
	return valid;
}



void drawRichKeypoints(const cv::Mat& src, std::vector<cv::KeyPoint>& kpts, cv::Mat& dst)
{

	cv::Mat grayFrame;
	cvtColor(src, grayFrame, CV_RGB2GRAY);
	cvtColor(grayFrame, dst, CV_GRAY2RGB);

	if (kpts.size() == 0) {
		return;
	}

	std::vector<cv::KeyPoint> kpts_cpy, kpts_sorted;

	kpts_cpy.insert(kpts_cpy.end(), kpts.begin(), kpts.end());

	double maxResponse = kpts_cpy.at(0).response;
	double minResponse = kpts_cpy.at(0).response;

	while (kpts_cpy.size() > 0) {

		double maxR = 0.0;
		unsigned int idx = 0;

		for (unsigned int iii = 0; iii < kpts_cpy.size(); iii++) {

			if (kpts_cpy.at(iii).response > maxR) {
				maxR = kpts_cpy.at(iii).response;
				idx = iii;
			}

			if (kpts_cpy.at(iii).response > maxResponse) {
				maxResponse = kpts_cpy.at(iii).response;
			}

			if (kpts_cpy.at(iii).response < minResponse) {
				minResponse = kpts_cpy.at(iii).response;
			}
		}

		kpts_sorted.push_back(kpts_cpy.at(idx));
		kpts_cpy.erase(kpts_cpy.begin() + idx);

	}

	int thickness = 1;
	cv::Point center;
	cv::Scalar colour;
	int red = 0, blue = 0, green = 0;
	int radius;
	double normalizedScore;

	if (minResponse == maxResponse) {
		colour = CV_RGB(255, 0, 0);
	}

	for (int iii = (int)kpts_sorted.size()-1; iii >= 0; iii--) {

		if (minResponse != maxResponse) {
			normalizedScore = pow((kpts_sorted.at(iii).response - minResponse) / (maxResponse - minResponse), 0.25);
			red = int(255.0 * normalizedScore);
			green = int(255.0 - 255.0 * normalizedScore);
			colour = CV_RGB(red, green, blue);
		}

		center = kpts_sorted.at(iii).pt;
		center.x *= 16;
		center.y *= 16;

		radius = (int)(16.0 * ((double)(kpts_sorted.at(iii).size)/2.0));

		if (radius > 0) {
			circle(dst, center, radius, colour, thickness, CV_AA, 4);
		}

	}

}

} // namespace slam
