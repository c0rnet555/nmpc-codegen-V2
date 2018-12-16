# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.5

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


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
CMAKE_SOURCE_DIR = /home/nick/nmpc-codegen-python/demos/robot_controller_builds/robot_controller

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/nick/nmpc-codegen-python/demos/robot_controller_builds/robot_controller/build

# Include any dependencies generated for this target.
include casadi/CMakeFiles/CASADI_lib.dir/depend.make

# Include the progress variables for this target.
include casadi/CMakeFiles/CASADI_lib.dir/progress.make

# Include the compile flags for this target's objects.
include casadi/CMakeFiles/CASADI_lib.dir/flags.make

casadi/CMakeFiles/CASADI_lib.dir/cost_function_derivative_combined.c.o: casadi/CMakeFiles/CASADI_lib.dir/flags.make
casadi/CMakeFiles/CASADI_lib.dir/cost_function_derivative_combined.c.o: ../casadi/cost_function_derivative_combined.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/nick/nmpc-codegen-python/demos/robot_controller_builds/robot_controller/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object casadi/CMakeFiles/CASADI_lib.dir/cost_function_derivative_combined.c.o"
	cd /home/nick/nmpc-codegen-python/demos/robot_controller_builds/robot_controller/build/casadi && gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/CASADI_lib.dir/cost_function_derivative_combined.c.o   -c /home/nick/nmpc-codegen-python/demos/robot_controller_builds/robot_controller/casadi/cost_function_derivative_combined.c

casadi/CMakeFiles/CASADI_lib.dir/cost_function_derivative_combined.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/CASADI_lib.dir/cost_function_derivative_combined.c.i"
	cd /home/nick/nmpc-codegen-python/demos/robot_controller_builds/robot_controller/build/casadi && gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/nick/nmpc-codegen-python/demos/robot_controller_builds/robot_controller/casadi/cost_function_derivative_combined.c > CMakeFiles/CASADI_lib.dir/cost_function_derivative_combined.c.i

casadi/CMakeFiles/CASADI_lib.dir/cost_function_derivative_combined.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/CASADI_lib.dir/cost_function_derivative_combined.c.s"
	cd /home/nick/nmpc-codegen-python/demos/robot_controller_builds/robot_controller/build/casadi && gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/nick/nmpc-codegen-python/demos/robot_controller_builds/robot_controller/casadi/cost_function_derivative_combined.c -o CMakeFiles/CASADI_lib.dir/cost_function_derivative_combined.c.s

casadi/CMakeFiles/CASADI_lib.dir/cost_function_derivative_combined.c.o.requires:

.PHONY : casadi/CMakeFiles/CASADI_lib.dir/cost_function_derivative_combined.c.o.requires

casadi/CMakeFiles/CASADI_lib.dir/cost_function_derivative_combined.c.o.provides: casadi/CMakeFiles/CASADI_lib.dir/cost_function_derivative_combined.c.o.requires
	$(MAKE) -f casadi/CMakeFiles/CASADI_lib.dir/build.make casadi/CMakeFiles/CASADI_lib.dir/cost_function_derivative_combined.c.o.provides.build
.PHONY : casadi/CMakeFiles/CASADI_lib.dir/cost_function_derivative_combined.c.o.provides

casadi/CMakeFiles/CASADI_lib.dir/cost_function_derivative_combined.c.o.provides.build: casadi/CMakeFiles/CASADI_lib.dir/cost_function_derivative_combined.c.o


casadi/CMakeFiles/CASADI_lib.dir/cost_function.c.o: casadi/CMakeFiles/CASADI_lib.dir/flags.make
casadi/CMakeFiles/CASADI_lib.dir/cost_function.c.o: ../casadi/cost_function.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/nick/nmpc-codegen-python/demos/robot_controller_builds/robot_controller/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object casadi/CMakeFiles/CASADI_lib.dir/cost_function.c.o"
	cd /home/nick/nmpc-codegen-python/demos/robot_controller_builds/robot_controller/build/casadi && gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/CASADI_lib.dir/cost_function.c.o   -c /home/nick/nmpc-codegen-python/demos/robot_controller_builds/robot_controller/casadi/cost_function.c

casadi/CMakeFiles/CASADI_lib.dir/cost_function.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/CASADI_lib.dir/cost_function.c.i"
	cd /home/nick/nmpc-codegen-python/demos/robot_controller_builds/robot_controller/build/casadi && gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/nick/nmpc-codegen-python/demos/robot_controller_builds/robot_controller/casadi/cost_function.c > CMakeFiles/CASADI_lib.dir/cost_function.c.i

casadi/CMakeFiles/CASADI_lib.dir/cost_function.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/CASADI_lib.dir/cost_function.c.s"
	cd /home/nick/nmpc-codegen-python/demos/robot_controller_builds/robot_controller/build/casadi && gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/nick/nmpc-codegen-python/demos/robot_controller_builds/robot_controller/casadi/cost_function.c -o CMakeFiles/CASADI_lib.dir/cost_function.c.s

casadi/CMakeFiles/CASADI_lib.dir/cost_function.c.o.requires:

.PHONY : casadi/CMakeFiles/CASADI_lib.dir/cost_function.c.o.requires

casadi/CMakeFiles/CASADI_lib.dir/cost_function.c.o.provides: casadi/CMakeFiles/CASADI_lib.dir/cost_function.c.o.requires
	$(MAKE) -f casadi/CMakeFiles/CASADI_lib.dir/build.make casadi/CMakeFiles/CASADI_lib.dir/cost_function.c.o.provides.build
.PHONY : casadi/CMakeFiles/CASADI_lib.dir/cost_function.c.o.provides

casadi/CMakeFiles/CASADI_lib.dir/cost_function.c.o.provides.build: casadi/CMakeFiles/CASADI_lib.dir/cost_function.c.o


casadi/CMakeFiles/CASADI_lib.dir/integrator.c.o: casadi/CMakeFiles/CASADI_lib.dir/flags.make
casadi/CMakeFiles/CASADI_lib.dir/integrator.c.o: ../casadi/integrator.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/nick/nmpc-codegen-python/demos/robot_controller_builds/robot_controller/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building C object casadi/CMakeFiles/CASADI_lib.dir/integrator.c.o"
	cd /home/nick/nmpc-codegen-python/demos/robot_controller_builds/robot_controller/build/casadi && gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/CASADI_lib.dir/integrator.c.o   -c /home/nick/nmpc-codegen-python/demos/robot_controller_builds/robot_controller/casadi/integrator.c

casadi/CMakeFiles/CASADI_lib.dir/integrator.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/CASADI_lib.dir/integrator.c.i"
	cd /home/nick/nmpc-codegen-python/demos/robot_controller_builds/robot_controller/build/casadi && gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/nick/nmpc-codegen-python/demos/robot_controller_builds/robot_controller/casadi/integrator.c > CMakeFiles/CASADI_lib.dir/integrator.c.i

casadi/CMakeFiles/CASADI_lib.dir/integrator.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/CASADI_lib.dir/integrator.c.s"
	cd /home/nick/nmpc-codegen-python/demos/robot_controller_builds/robot_controller/build/casadi && gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/nick/nmpc-codegen-python/demos/robot_controller_builds/robot_controller/casadi/integrator.c -o CMakeFiles/CASADI_lib.dir/integrator.c.s

casadi/CMakeFiles/CASADI_lib.dir/integrator.c.o.requires:

.PHONY : casadi/CMakeFiles/CASADI_lib.dir/integrator.c.o.requires

casadi/CMakeFiles/CASADI_lib.dir/integrator.c.o.provides: casadi/CMakeFiles/CASADI_lib.dir/integrator.c.o.requires
	$(MAKE) -f casadi/CMakeFiles/CASADI_lib.dir/build.make casadi/CMakeFiles/CASADI_lib.dir/integrator.c.o.provides.build
.PHONY : casadi/CMakeFiles/CASADI_lib.dir/integrator.c.o.provides

casadi/CMakeFiles/CASADI_lib.dir/integrator.c.o.provides.build: casadi/CMakeFiles/CASADI_lib.dir/integrator.c.o


# Object files for target CASADI_lib
CASADI_lib_OBJECTS = \
"CMakeFiles/CASADI_lib.dir/cost_function_derivative_combined.c.o" \
"CMakeFiles/CASADI_lib.dir/cost_function.c.o" \
"CMakeFiles/CASADI_lib.dir/integrator.c.o"

# External object files for target CASADI_lib
CASADI_lib_EXTERNAL_OBJECTS =

casadi/libCASADI_lib.a: casadi/CMakeFiles/CASADI_lib.dir/cost_function_derivative_combined.c.o
casadi/libCASADI_lib.a: casadi/CMakeFiles/CASADI_lib.dir/cost_function.c.o
casadi/libCASADI_lib.a: casadi/CMakeFiles/CASADI_lib.dir/integrator.c.o
casadi/libCASADI_lib.a: casadi/CMakeFiles/CASADI_lib.dir/build.make
casadi/libCASADI_lib.a: casadi/CMakeFiles/CASADI_lib.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/nick/nmpc-codegen-python/demos/robot_controller_builds/robot_controller/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Linking C static library libCASADI_lib.a"
	cd /home/nick/nmpc-codegen-python/demos/robot_controller_builds/robot_controller/build/casadi && $(CMAKE_COMMAND) -P CMakeFiles/CASADI_lib.dir/cmake_clean_target.cmake
	cd /home/nick/nmpc-codegen-python/demos/robot_controller_builds/robot_controller/build/casadi && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/CASADI_lib.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
casadi/CMakeFiles/CASADI_lib.dir/build: casadi/libCASADI_lib.a

.PHONY : casadi/CMakeFiles/CASADI_lib.dir/build

casadi/CMakeFiles/CASADI_lib.dir/requires: casadi/CMakeFiles/CASADI_lib.dir/cost_function_derivative_combined.c.o.requires
casadi/CMakeFiles/CASADI_lib.dir/requires: casadi/CMakeFiles/CASADI_lib.dir/cost_function.c.o.requires
casadi/CMakeFiles/CASADI_lib.dir/requires: casadi/CMakeFiles/CASADI_lib.dir/integrator.c.o.requires

.PHONY : casadi/CMakeFiles/CASADI_lib.dir/requires

casadi/CMakeFiles/CASADI_lib.dir/clean:
	cd /home/nick/nmpc-codegen-python/demos/robot_controller_builds/robot_controller/build/casadi && $(CMAKE_COMMAND) -P CMakeFiles/CASADI_lib.dir/cmake_clean.cmake
.PHONY : casadi/CMakeFiles/CASADI_lib.dir/clean

casadi/CMakeFiles/CASADI_lib.dir/depend:
	cd /home/nick/nmpc-codegen-python/demos/robot_controller_builds/robot_controller/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/nick/nmpc-codegen-python/demos/robot_controller_builds/robot_controller /home/nick/nmpc-codegen-python/demos/robot_controller_builds/robot_controller/casadi /home/nick/nmpc-codegen-python/demos/robot_controller_builds/robot_controller/build /home/nick/nmpc-codegen-python/demos/robot_controller_builds/robot_controller/build/casadi /home/nick/nmpc-codegen-python/demos/robot_controller_builds/robot_controller/build/casadi/CMakeFiles/CASADI_lib.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : casadi/CMakeFiles/CASADI_lib.dir/depend

