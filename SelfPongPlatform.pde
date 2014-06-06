/*
[ Self - Pong ]
by Gildas P. / http://www.gildasp.fr/playingwithpixels/
*/

class SelfPongPlatform {

  int posx, posy;
  int sens, larg, haut, vitbase;
  float vitx, vity, decel, accel;
  ColliderRect collider1, collider2;

  SelfPongPlatform(int _x, int _y) {
    posx = _x;
    posy = _y;
    vitx = 0;
    vity = 0;
    float tmp = random(-1, 1);
    if(tmp>0){
      sens = 1;
    } else {
      sens = -1;
    }
    
    vitbase = 15;
    decel = 0.8;
    accel = 3;

    larg = 10;
    haut = 100;
    
    collider1 = new ColliderRect(posx, posy, larg, haut);
    collider2 = new ColliderRect(width-posx, height-posy, larg, haut);
  } 
  
  void stopPlatform(){
    vitx = 0;
    if(abs(vity)<0.5){ vity = 0; }
    vity *= 0.7;
  }
  void updatePlatform() {
    posx += vitx;
    posy += vity;
    
    if(posy<-1*haut/2){ posy += height+haut; }
    if(posy>height+haut/2){ posy -= height+haut; }
    
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
    
    fill(255, 255, 255);
    if(score1>score2){ fill(255, 153, 0); }
    // 1er  rectangle
    rect(posx, posy, larg, haut);
    // 2ème rectangle
    fill(255, 255, 255);
    if(score1<score2){ fill(255, 153, 0); }
    rect(width-posx, height-posy, larg, haut);
    
    fill(255, 255, 255);
    
    //collider1.drawCollider();
    //collider2.drawCollider();
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

