/* file generated on 12/16/18 at 16:13:46 */

void casadi_interface_proxg(real_t* state){
    size_t i;
    for(i=0;i<MPC_HORIZON;i++){
        /* check if the value of the border is outside the box, if so go to the nearest point inside the box */
        if(state[0]<-1){
            state[0]=-1;
        }else if(state[0]>1){
            state[0]=1;
        }else{
            state[0]=state[0];
        }
        /* check if the value of the border is outside the box, if so go to the nearest point inside the box */
        if(state[1]<-2){
            state[1]=-2;
        }else if(state[1]>2){
            state[1]=2;
        }else{
            state[1]=state[1];
        }
        state+=2;
    }

}
