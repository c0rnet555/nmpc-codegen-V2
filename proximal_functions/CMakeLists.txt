### make sure the user is doing an our of source build:
 if ( ${CMAKE_SOURCE_DIR} STREQUAL ${CMAKE_BINARY_DIR} )
     message( FATAL_ERROR "In-source builds are not allowed. use cmake -H. -Bbuild instead to build in the build folder" )
 endif()
###

cmake_minimum_required (VERSION 2.6)
project (panoc C)

# set the compiler with its flags
# SET(CMAKE_C_COMPILER gcc)
SET(CMAKE_BUILD_TYPE Debug)
if(NOT MSVC)
    set(CMAKE_C_FLAGS_DEBUG "-g -O0 -Wall -Wextra -fprofile-arcs -ftest-coverage")
    set(LDFLAGS "-O0 -fprofile-arcs -ftest-coverage")
    SET(CMAKE_EXE_LINKER_FLAGS="-fprofile-arcs -ftest-coverage")
endif()

# subdirectories with libraries
include_directories ("${PROJECT_SOURCE_DIR}/src")
add_subdirectory (src) # read out the cmakelist file

include_directories ("${PROJECT_SOURCE_DIR}/test")
add_subdirectory(test)

# Test the functionality
enable_testing()

# Tests on the matrix/vector operations 
add_test(NAME indicator_box_test COMMAND  test/indicator_box_test)
add_test(NAME indicator_bin_test COMMAND  test/indicator_bin_test)
add_test(NAME quicksort_test COMMAND  test/quicksort_test)