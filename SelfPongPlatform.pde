/*
[ Self - Pong ]
by Gildas P. / http://www.gildasp.fr/playingwithpixels/
*/

class SelfPongPlatform {

  int posx, posy;
  int sens, larg, haut, vitbase;
  float vitx, vity, decel, accel;
  ColliderRect collider1, collider2, 
               collider3, collider4;
  int DIR_LEFT = 0;
  int DIR_RIGHT = 1;
  int DIR_UP = 2;
  int DIR_DOWN = 3;

  SelfPongPlatform(int _x, int _y) {
    posx = _x;
    posy = _y;
    vitx = 0;
    vity = 0;
    
    // Decides who gets regular conrol and who gets
    // inverse controls. sens = forward/backward?
    float tmp = random(-1, 1);
    if(tmp>0){
      sens = 1;
    } else {
      sens = -1;
    }
    
    vitbase = 15; // base velocity
    decel = 0.8;  // rate of deacceleration
    accel = 3;    // rate of acceleration

    larg = 10;    // width
    haut = 100;   // height
    
    collider1 = new ColliderRect(posx, posy, larg, haut, 2);
    collider2 = new ColliderRect(width-posx, height-posy, larg, haut, 2);
    //collider3 = new ColliderRect(width/2, 30, haut, larg, 1);
    //collider4 = new ColliderRect(width/2, height-30, haut, larg, 1);
  } 
  
  //  
  void stopPlatform(){
    vitx = 0;
    if(abs(vity)<0.5){ vity = 0; }
    vity *= 0.7;
  }
  
  void updatePlatform() {
    // add velocity to position
    posx += vitx;
    posy += vity;
    
    // screen wrapping
    if(posy<-1*haut/2){ posy += height+haut; }
    if(posy>height+haut/2){ posy -= height+haut; }
    
    // update collider boxen
    collider1.larg = larg;
    collider1.haut = haut;
    collider1.posx = posx;
    collider1.posy = posy;
    
    collider2.larg = larg;
    collider2.haut = haut;
    collider2.posx = width-posx;
    collider2.posy = height-posy;
  }

  void drawPlatform() {
    
    // couleur on keypressed
    /*if(abs(vity)>0){
      fill(255, 153, 0);
    } else {      
      fill(255, 255, 255);
    }*/
    
    // 1er  rectangle = left paddle
    fill(255, 255, 255);
    if(score1>score2){ fill(255, 153, 0); }
    rect(posx, posy, larg, haut);
    fill(255, 255, 255);
    
    // 2ème rectangle = right paddle
    if(score1<score2){ fill(255, 153, 0); }
    rect(width-posx, height-posy, larg, haut);
    fill(255, 255, 255);
    
    // 3eme rectangle = top paddle
    rect(width/2, 30, haut, larg);
    
    // 4eme rectangle = bottom paddle
    rect(width/2, height-30, haut, larg);
    

  }
  
  void keyUp(){
    if(abs(vity)<0.5){ vity = 0.55; }
    vity = sens*min(vitbase, abs(vity)*accel);
    //vity = -1*sens*vitbase;
  }  
  void keyDown(){
    if(abs(vity)<0.5){ vity = -0.55; }
    vity = -1*sens*min(vitbase, abs(vity)*accel);
    //vity = sens*vitbase;
  }

  void gameover() {
  }
}

