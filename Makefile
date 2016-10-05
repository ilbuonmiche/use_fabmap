# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 2.8

# Default target executed when no arguments are given to make.
default_target: all
.PHONY : default_target

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list

# Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = "/home/michele/Documents/master thesis/softwares/workspace/use_fabmap"

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/michele/Documents/workspace/use_fabmap

#=============================================================================
# Targets provided globally by CMake.

# Special rule for the target edit_cache
edit_cache:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "Running interactive CMake command-line interface..."
	/usr/bin/cmake -i .
.PHONY : edit_cache

# Special rule for the target edit_cache
edit_cache/fast: edit_cache
.PHONY : edit_cache/fast

# Special rule for the target rebuild_cache
rebuild_cache:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "Running CMake to regenerate build system..."
	/usr/bin/cmake -H$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR)
.PHONY : rebuild_cache

# Special rule for the target rebuild_cache
rebuild_cache/fast: rebuild_cache
.PHONY : rebuild_cache/fast

# The main all target
all: cmake_check_build_system
	$(CMAKE_COMMAND) -E cmake_progress_start /home/michele/Documents/workspace/use_fabmap/CMakeFiles /home/michele/Documents/workspace/use_fabmap/CMakeFiles/progress.marks
	$(MAKE) -f CMakeFiles/Makefile2 all
	$(CMAKE_COMMAND) -E cmake_progress_start /home/michele/Documents/workspace/use_fabmap/CMakeFiles 0
.PHONY : all

# The main clean target
clean:
	$(MAKE) -f CMakeFiles/Makefile2 clean
.PHONY : clean

# The main clean target
clean/fast: clean
.PHONY : clean/fast

# Prepare targets for installation.
preinstall: all
	$(MAKE) -f CMakeFiles/Makefile2 preinstall
.PHONY : preinstall

# Prepare targets for installation.
preinstall/fast:
	$(MAKE) -f CMakeFiles/Makefile2 preinstall
.PHONY : preinstall/fast

# clear depends
depend:
	$(CMAKE_COMMAND) -H$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR) --check-build-system CMakeFiles/Makefile.cmake 1
.PHONY : depend

#=============================================================================
# Target rules for targets named use_fabmap

# Build rule for target.
use_fabmap: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 use_fabmap
.PHONY : use_fabmap

# fast build rule for target.
use_fabmap/fast:
	$(MAKE) -f CMakeFiles/use_fabmap.dir/build.make CMakeFiles/use_fabmap.dir/build
.PHONY : use_fabmap/fast

#=============================================================================
# Target rules for targets named use_fabmap_video_city_centre

# Build rule for target.
use_fabmap_video_city_centre: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 use_fabmap_video_city_centre
.PHONY : use_fabmap_video_city_centre

# fast build rule for target.
use_fabmap_video_city_centre/fast:
	$(MAKE) -f CMakeFiles/use_fabmap_video_city_centre.dir/build.make CMakeFiles/use_fabmap_video_city_centre.dir/build
.PHONY : use_fabmap_video_city_centre/fast

#=============================================================================
# Target rules for targets named use_fabmap_video_mono

# Build rule for target.
use_fabmap_video_mono: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 use_fabmap_video_mono
.PHONY : use_fabmap_video_mono

# fast build rule for target.
use_fabmap_video_mono/fast:
	$(MAKE) -f CMakeFiles/use_fabmap_video_mono.dir/build.make CMakeFiles/use_fabmap_video_mono.dir/build
.PHONY : use_fabmap_video_mono/fast

#=============================================================================
# Target rules for targets named use_fabmap_video_st_lucia

# Build rule for target.
use_fabmap_video_st_lucia: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 use_fabmap_video_st_lucia
.PHONY : use_fabmap_video_st_lucia

# fast build rule for target.
use_fabmap_video_st_lucia/fast:
	$(MAKE) -f CMakeFiles/use_fabmap_video_st_lucia.dir/build.make CMakeFiles/use_fabmap_video_st_lucia.dir/build
.PHONY : use_fabmap_video_st_lucia/fast

#=============================================================================
# Target rules for targets named openFABMAP

# Build rule for target.
openFABMAP: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 openFABMAP
.PHONY : openFABMAP

# fast build rule for target.
openFABMAP/fast:
	$(MAKE) -f openfabmap/CMakeFiles/openFABMAP.dir/build.make openfabmap/CMakeFiles/openFABMAP.dir/build
.PHONY : openFABMAP/fast

src/FabMap.o: src/FabMap.cpp.o
.PHONY : src/FabMap.o

# target to build an object file
src/FabMap.cpp.o:
	$(MAKE) -f CMakeFiles/use_fabmap.dir/build.make CMakeFiles/use_fabmap.dir/src/FabMap.cpp.o
	$(MAKE) -f CMakeFiles/use_fabmap_video_city_centre.dir/build.make CMakeFiles/use_fabmap_video_city_centre.dir/src/FabMap.cpp.o
	$(MAKE) -f CMakeFiles/use_fabmap_video_mono.dir/build.make CMakeFiles/use_fabmap_video_mono.dir/src/FabMap.cpp.o
	$(MAKE) -f CMakeFiles/use_fabmap_video_st_lucia.dir/build.make CMakeFiles/use_fabmap_video_st_lucia.dir/src/FabMap.cpp.o
.PHONY : src/FabMap.cpp.o

src/FabMap.i: src/FabMap.cpp.i
.PHONY : src/FabMap.i

# target to preprocess a source file
src/FabMap.cpp.i:
	$(MAKE) -f CMakeFiles/use_fabmap.dir/build.make CMakeFiles/use_fabmap.dir/src/FabMap.cpp.i
	$(MAKE) -f CMakeFiles/use_fabmap_video_city_centre.dir/build.make CMakeFiles/use_fabmap_video_city_centre.dir/src/FabMap.cpp.i
	$(MAKE) -f CMakeFiles/use_fabmap_video_mono.dir/build.make CMakeFiles/use_fabmap_video_mono.dir/src/FabMap.cpp.i
	$(MAKE) -f CMakeFiles/use_fabmap_video_st_lucia.dir/build.make CMakeFiles/use_fabmap_video_st_lucia.dir/src/FabMap.cpp.i
.PHONY : src/FabMap.cpp.i

src/FabMap.s: src/FabMap.cpp.s
.PHONY : src/FabMap.s

# target to generate assembly for a file
src/FabMap.cpp.s:
	$(MAKE) -f CMakeFiles/use_fabmap.dir/build.make CMakeFiles/use_fabmap.dir/src/FabMap.cpp.s
	$(MAKE) -f CMakeFiles/use_fabmap_video_city_centre.dir/build.make CMakeFiles/use_fabmap_video_city_centre.dir/src/FabMap.cpp.s
	$(MAKE) -f CMakeFiles/use_fabmap_video_mono.dir/build.make CMakeFiles/use_fabmap_video_mono.dir/src/FabMap.cpp.s
	$(MAKE) -f CMakeFiles/use_fabmap_video_st_lucia.dir/build.make CMakeFiles/use_fabmap_video_st_lucia.dir/src/FabMap.cpp.s
.PHONY : src/FabMap.cpp.s

src/use_fabmap.o: src/use_fabmap.cpp.o
.PHONY : src/use_fabmap.o

# target to build an object file
src/use_fabmap.cpp.o:
	$(MAKE) -f CMakeFiles/use_fabmap.dir/build.make CMakeFiles/use_fabmap.dir/src/use_fabmap.cpp.o
.PHONY : src/use_fabmap.cpp.o

src/use_fabmap.i: src/use_fabmap.cpp.i
.PHONY : src/use_fabmap.i

# target to preprocess a source file
src/use_fabmap.cpp.i:
	$(MAKE) -f CMakeFiles/use_fabmap.dir/build.make CMakeFiles/use_fabmap.dir/src/use_fabmap.cpp.i
.PHONY : src/use_fabmap.cpp.i

src/use_fabmap.s: src/use_fabmap.cpp.s
.PHONY : src/use_fabmap.s

# target to generate assembly for a file
src/use_fabmap.cpp.s:
	$(MAKE) -f CMakeFiles/use_fabmap.dir/build.make CMakeFiles/use_fabmap.dir/src/use_fabmap.cpp.s
.PHONY : src/use_fabmap.cpp.s

src/use_fabmap_video_city_center.o: src/use_fabmap_video_city_center.cpp.o
.PHONY : src/use_fabmap_video_city_center.o

# target to build an object file
src/use_fabmap_video_city_center.cpp.o:
	$(MAKE) -f CMakeFiles/use_fabmap_video_city_centre.dir/build.make CMakeFiles/use_fabmap_video_city_centre.dir/src/use_fabmap_video_city_center.cpp.o
.PHONY : src/use_fabmap_video_city_center.cpp.o

src/use_fabmap_video_city_center.i: src/use_fabmap_video_city_center.cpp.i
.PHONY : src/use_fabmap_video_city_center.i

# target to preprocess a source file
src/use_fabmap_video_city_center.cpp.i:
	$(MAKE) -f CMakeFiles/use_fabmap_video_city_centre.dir/build.make CMakeFiles/use_fabmap_video_city_centre.dir/src/use_fabmap_video_city_center.cpp.i
.PHONY : src/use_fabmap_video_city_center.cpp.i

src/use_fabmap_video_city_center.s: src/use_fabmap_video_city_center.cpp.s
.PHONY : src/use_fabmap_video_city_center.s

# target to generate assembly for a file
src/use_fabmap_video_city_center.cpp.s:
	$(MAKE) -f CMakeFiles/use_fabmap_video_city_centre.dir/build.make CMakeFiles/use_fabmap_video_city_centre.dir/src/use_fabmap_video_city_center.cpp.s
.PHONY : src/use_fabmap_video_city_center.cpp.s

src/use_fabmap_video_mono.o: src/use_fabmap_video_mono.cpp.o
.PHONY : src/use_fabmap_video_mono.o

# target to build an object file
src/use_fabmap_video_mono.cpp.o:
	$(MAKE) -f CMakeFiles/use_fabmap_video_mono.dir/build.make CMakeFiles/use_fabmap_video_mono.dir/src/use_fabmap_video_mono.cpp.o
.PHONY : src/use_fabmap_video_mono.cpp.o

src/use_fabmap_video_mono.i: src/use_fabmap_video_mono.cpp.i
.PHONY : src/use_fabmap_video_mono.i

# target to preprocess a source file
src/use_fabmap_video_mono.cpp.i:
	$(MAKE) -f CMakeFiles/use_fabmap_video_mono.dir/build.make CMakeFiles/use_fabmap_video_mono.dir/src/use_fabmap_video_mono.cpp.i
.PHONY : src/use_fabmap_video_mono.cpp.i

src/use_fabmap_video_mono.s: src/use_fabmap_video_mono.cpp.s
.PHONY : src/use_fabmap_video_mono.s

# target to generate assembly for a file
src/use_fabmap_video_mono.cpp.s:
	$(MAKE) -f CMakeFiles/use_fabmap_video_mono.dir/build.make CMakeFiles/use_fabmap_video_mono.dir/src/use_fabmap_video_mono.cpp.s
.PHONY : src/use_fabmap_video_mono.cpp.s

src/use_fabmap_video_st_lucia.o: src/use_fabmap_video_st_lucia.cpp.o
.PHONY : src/use_fabmap_video_st_lucia.o

# target to build an object file
src/use_fabmap_video_st_lucia.cpp.o:
	$(MAKE) -f CMakeFiles/use_fabmap_video_st_lucia.dir/build.make CMakeFiles/use_fabmap_video_st_lucia.dir/src/use_fabmap_video_st_lucia.cpp.o
.PHONY : src/use_fabmap_video_st_lucia.cpp.o

src/use_fabmap_video_st_lucia.i: src/use_fabmap_video_st_lucia.cpp.i
.PHONY : src/use_fabmap_video_st_lucia.i

# target to preprocess a source file
src/use_fabmap_video_st_lucia.cpp.i:
	$(MAKE) -f CMakeFiles/use_fabmap_video_st_lucia.dir/build.make CMakeFiles/use_fabmap_video_st_lucia.dir/src/use_fabmap_video_st_lucia.cpp.i
.PHONY : src/use_fabmap_video_st_lucia.cpp.i

src/use_fabmap_video_st_lucia.s: src/use_fabmap_video_st_lucia.cpp.s
.PHONY : src/use_fabmap_video_st_lucia.s

# target to generate assembly for a file
src/use_fabmap_video_st_lucia.cpp.s:
	$(MAKE) -f CMakeFiles/use_fabmap_video_st_lucia.dir/build.make CMakeFiles/use_fabmap_video_st_lucia.dir/src/use_fabmap_video_st_lucia.cpp.s
.PHONY : src/use_fabmap_video_st_lucia.cpp.s

# Help Target
help:
	@echo "The following are some of the valid targets for this Makefile:"
	@echo "... all (the default if no target is provided)"
	@echo "... clean"
	@echo "... depend"
	@echo "... edit_cache"
	@echo "... rebuild_cache"
	@echo "... use_fabmap"
	@echo "... use_fabmap_video_city_centre"
	@echo "... use_fabmap_video_mono"
	@echo "... use_fabmap_video_st_lucia"
	@echo "... openFABMAP"
	@echo "... src/FabMap.o"
	@echo "... src/FabMap.i"
	@echo "... src/FabMap.s"
	@echo "... src/use_fabmap.o"
	@echo "... src/use_fabmap.i"
	@echo "... src/use_fabmap.s"
	@echo "... src/use_fabmap_video_city_center.o"
	@echo "... src/use_fabmap_video_city_center.i"
	@echo "... src/use_fabmap_video_city_center.s"
	@echo "... src/use_fabmap_video_mono.o"
	@echo "... src/use_fabmap_video_mono.i"
	@echo "... src/use_fabmap_video_mono.s"
	@echo "... src/use_fabmap_video_st_lucia.o"
	@echo "... src/use_fabmap_video_st_lucia.i"
	@echo "... src/use_fabmap_video_st_lucia.s"
.PHONY : help



#=============================================================================
# Special targets to cleanup operation of make.

# Special rule to run CMake to check the build system integrity.
# No rule that depends on this can have commands that come from listfiles
# because they might be regenerated.
cmake_check_build_system:
	$(CMAKE_COMMAND) -H$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR) --check-build-system CMakeFiles/Makefile.cmake 0
.PHONY : cmake_check_build_system

