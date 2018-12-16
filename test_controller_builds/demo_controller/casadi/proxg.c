/* file generated on 12/06/18 at 22:58:42 */

void casadi_interface_proxg(real_t* state){
    size_t i;
    for(i=0;i<MPC_HORIZON;i++){
        /* check if the value of the border is outside the box, if so go to the nearest point inside the box */
        if(state[0]<-4){
            state[0]=-4;
        }else if(state[0]>4){
            state[0]=4;
        }else{
            state[0]=state[0];
        }
        /* check if the value of the border is outside the box, if so go to the nearest point inside the box */
        if(state[1]<-4){
            state[1]=-4;
        }else if(state[1]>4){
            state[1]=4;
        }else{
            state[1]=state[1];
        }
        state+=2;
    }

}
