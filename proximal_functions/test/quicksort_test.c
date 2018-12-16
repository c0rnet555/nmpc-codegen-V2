#include "../globals/globals.h"
#include "../src/internal_lib/quicksort.h"
#include "stdio.h"
#include "stdlib.h"
/*
static void print_array_positions(real_t* numbers,unsigned int* positions){
    printf(" %f %f %f %f %f %f \n",numbers[positions[0]],numbers[positions[1]],numbers[positions[2]],numbers[positions[3]],numbers[positions[4]],numbers[positions[5]]);
}
static void print_array(real_t* numbers){
    printf(" %f %f %f %f %f %f \n",numbers[0],numbers[1],numbers[2],numbers[3],numbers[4],numbers[5]);
}
*/

static int test_solution(real_t* test_result,real_t* solution,unsigned int length){
    unsigned int i;
    
    for(i = 0; i < length; i++){
        if( ABS(test_result[i]-solution[i])> MACHINE_ACCURACY){
            printf("Error result=[%f %f %f %f %f %f] solution=[%f %f %f %f %f %f] \n",\
                test_result[0],test_result[1],test_result[2],test_result[3],test_result[4],test_result[5],\
                solution[0],solution[1],solution[2],solution[3],solution[4],solution[5]);
            return FAILURE;
        }
    }
    
    return SUCCESS;
}
static int test_solution_positions(real_t* starting_array, real_t* solution, unsigned int* positions, unsigned int length){
    unsigned int i;
    
    for(i = 0; i < length; i++){
        if( ABS(starting_array[i]-solution[positions[i]])> MACHINE_ACCURACY){
            printf("Error result=[%f %f %f %f %f %f] solution=[%f %f %f %f %f %f] \n",\
                starting_array[positions[0]],starting_array[positions[1]],starting_array[positions[2]],\
                starting_array[positions[3]],starting_array[positions[4]],starting_array[positions[5]],\
                solution[0],solution[1],solution[2],solution[3],solution[4],solution[5]);
            return FAILURE;
        }
    }
    
    return SUCCESS;
}
int main(){
    unsigned int length=6;
    real_t solution[6] = {0,1,2,3,4,5};
    real_t numbers[6] = {3,0,4,2,5,1};

    printf("Testing classic quicksort of array:\n");

    __quicksort_ascending(numbers,length);
    if(test_solution(numbers,solution,length)==FAILURE) 
        return FAILURE;

    printf("--- \n");

    printf("Testing position based quicksort of array:\n");

    real_t numbers2[6] = {3,0,4,2,5,1};
    unsigned int positions2[6];
    
    __quicksort_indices_ascending(numbers2,positions2,length);
    if(test_solution_positions(numbers2,solution,positions2,length)==FAILURE) 
        return FAILURE;

    return SUCCESS; /* if you made it this far, return SUCCESS all tests are ok */
}