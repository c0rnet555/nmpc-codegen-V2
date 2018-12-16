add_executable(indicator_box_test indicator_box_test.c)
target_link_libraries (indicator_box_test proximal_functions_lib)
if(NOT MSVC) # Microsoft Visual studio doesn't like this
    target_link_libraries(indicator_box_test m) # link with the math lib, some toolchains need this
endif()

add_executable(indicator_bin_test indicator_bin_test.c)
target_link_libraries (indicator_bin_test proximal_functions_lib)
if(NOT MSVC) # Microsoft Visual studio doesn't like this
    target_link_libraries(indicator_bin_test m) # link with the math lib, some toolchains need this
endif()

add_executable(quicksort_test quicksort_test.c)
target_link_libraries (quicksort_test proximal_functions_lib)
if(NOT MSVC) # Microsoft Visual studio doesn't like this
    target_link_libraries(quicksort_test m) # link with the math lib, some toolchains need this
endif()