/* file generated on 12/16/18 at 16:13:46 */

real_t casadi_interface_g(const real_t* state){
    size_t i;
    for(i=0;i<MPC_HORIZON;i++){
    /* check if the value of the border is outside the box, if so return zero */
    if(state[0]<-1 || state[0]>1){
        return LARGE;
    }
    /* check if the value of the border is outside the box, if so return zero */
    if(state[1]<-2 || state[1]>2){
        return LARGE;
    }
        state+=2;
    }
    /* if the value's where never outside the box, return zero */
    return 0;

}
