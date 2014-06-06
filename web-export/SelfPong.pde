/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/51554*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */
/*
[ Self - Pong ]
by Gildas P. / http://www.gildasp.fr/playingwithpixels/

Use arrows UP and Down to control both platforms...
Then it's pure Pong, the first of yourselves to beat 10 points wins !

Would like to run this with Kinect controls... don't know when.

[ Abstract - Arkanoid ] coming soon !

*/
SelfPongPlatform platforms;
SelfPongBall ball;
ArrayList listeColliders;
int score1, score2, scoreMax;
Boolean display_intro, display_youwin;

void setup(){
  size(640, 480);
  frameRate(25);
  smooth();
  background(0);
  textAlign(CENTER);
  
  scoreMax = 10;
  display_intro = true;
  display_youwin = false;
  
  platforms = new SelfPongPlatform(30, height/2);  
  ball = new SelfPongBall(width/2, height/2);
  listeColliders = new ArrayList();
  listeColliders.add(platforms.collider1);
  listeColliders.add(platforms.collider2);
  
  score1 = 0;
  score2 = 0;
  
  fill(255, 255, 255);
  noStroke();
  rectMode(CENTER);
}

void draw(){
  background(0);
  
  if(keylock == "up"){
    platforms.keyUp();
  }
  if(keylock == "down"){
    platforms.keyDown();
  }
  if(keylock == ""){
    platforms.stopPlatform();
  }
  platforms.updatePlatform();
      
  ball.updateBall();
  
  ball.lignes.drawLines();
  
  platforms.drawPlatform();
  ball.drawBall();
  
  //text(keylock, width/2, 30);
  text("[ Self-PONG ]", width/2, 30);
  text("You against yourself", width/2, 50);
  text(score1+"   /   "+score2, width/2, 90);  
  
  text("Ball Speed", width/2, height-50);
  text(ball.vitesse, width/2, height-30);
  
  // intro
  if(display_intro){ show_intro(); }
  if(display_youwin){ show_youwin(); }
}

void show_intro(){
  fill(255, 255, 255, 220);
  rect(width/2, height/2, 250, 150); 
  fill(0, 0, 0);
  text("Use arrow keys", width/2, height/2-40);
  text("to control both platforms...", width/2, height/2-20);
  text("The first of yourselves to "+scoreMax+" wins.", width/2, height/2+20);
  //text("Speed up !", width/2, height/2+50);
  text("[ Press Up or Down ]", width/2, height/2+40);
}
void show_youwin(){
  fill(255, 255, 255, 220);
  rect(width/2, height/2, 250, 150); 
  fill(0, 0, 0);
  text("[ You win !!! ]", width/2, height/2-30);
  if(score1>score2){
      text("Your left side rocks !", width/2, height/2-10);
  } else {
      text("Your right side is best !", width/2, height/2-10);
  }
  text("Beat yourself, try again...", width/2, height/2+30);
  text("[ Press Enter ]", width/2, height/2+50);
}

void test_gameover(){
  if(score1>=scoreMax || score2>=scoreMax){
    // you win !
    
    // pause game
    ball.posx = width/2;
    ball.posy = 120;
    ball.vitx = 0;
    ball.vity = 0;
    // display popup
    display_youwin = true;
    
    // hide lines    
    ball.lignes.initLines();
  }
}

void restart(){
  ball.posx = width/2;
  ball.posy = height/2;
  ball.vitx = 6;
  ball.vity = 0;
  score1 = 0;
  score2 = 0;
  ball.vitesse = 6;
    if(platforms.sens == -1){
      platforms.sens = 1;
    } else {
      platforms.sens = -1;
    }
  display_youwin = false;
}
/////

String keylock = "";

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      keylock = "up";
      display_intro = false;
    } else if (keyCode == DOWN) {
      keylock = "down";
      display_intro = false;
    } 
  }  
  if (key == ENTER && display_youwin){
    restart();
  }
}
void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP) {
      keylock = "";
    } else if (keyCode == DOWN) {
      keylock = "";
    } 
  }  
}
/*
[ Self - Pong ]
by Gildas P. / http://www.gildasp.fr/playingwithpixels/
*/

class ColliderRect {
  
  int posx, posy, larg, haut;
  
  ColliderRect(int _x, int _y, int _l, int _h){
    posx = _x;
    posy = _y;
    larg = _l;
    haut = _h;
  } 
  
  void updateCollider(){  }
  
  void drawCollider(){
      stroke(255, 0, 255);
      noFill();
      rect(posx, posy, larg, haut);
      noStroke();
  }
  
  // moteur de collisions rectangles
  
  Boolean collideRect (ColliderRect obj2){ // centré !
    if(abs(posx-obj2.posx)<(larg/2+obj2.larg/2) && abs(posy-obj2.posy)<(haut/2+obj2.haut/2)){
    	// colide !
    	return true;
    } else { 
      return false; 
    }
  }	
  ArrayList collideRectList (ArrayList objArray){
    Boolean collision = false;
    ArrayList colliders = new ArrayList();
    for(int k=0; k<objArray.size(); k++){
        ColliderRect obj = (ColliderRect) objArray.get(k);
    	if(objArray.get(k) != this && collideRect(obj)){
    	  collision = true;
    	  colliders.add(obj);
    	}
    } // retourne false ou la liste des collisionnés...
    //if(collision){
      return colliders;
    /*} else {
    	return false;
    }*/
  }
  float[] collideRectVector (ColliderRect obj2){	
    // retourne les vecteurs x et y à appliquer à this
    // ainsi que la longuer du vecteur (pour obtenir le vecteur unitaire facilement)
    // (l'autre s'occupera de lui-même)
    float vectx = (posx-obj2.posx)/2;
    float vecty = (posy-obj2.posy)/2;
    float distance = dist(posx, posy, obj2.posx, obj2.posy);
    
    float[] vecteur = { vectx, vecty, distance };
    return vecteur;
  }
  /*float[] collideRectUnitVector (ColliderRect obj2){
    float[] tmp = collideRectVector (obj2);
    float distance = dist(posx, posy, obj2.posx, obj2.posy);
    float vectx = tmp[0]/distance;
    float vecty = tmp[1]/distance;
    float[] vecteur = { vectx, vecty, distance };
    return vecteur;
  }*/
}
/*
[ Self - Pong ]
by Gildas P. / http://www.gildasp.fr/playingwithpixels/
*/

class DrawLines {
  
  ArrayList sommets;
  float posx, posy, posx2, posy2;
  int alphaInit, alphaGrow;
  float alphaBlur;
  int curalpha;

  DrawLines(float _x, float _y) {
    sommets = new ArrayList();
    posx = _x;
    posy = _y;
    posx2 = 0;
    posy2 = 0;
    
    alphaInit = 0;
    alphaGrow = 10;
    alphaBlur = -0.4;
    curalpha = alphaInit;
    
    float[] coords = {_x, _y, alphaInit};
    sommets.add(coords);
  } 
  
  void addLine(float _x, float _y){
    
    alphaInit = min(255, alphaInit+alphaGrow);
    float[] coords = {_x, _y, alphaInit};
    sommets.add(coords);
    
  }
  
  void drawLines(){
    for(int s=0; s<sommets.size(); s++){
      if(s>=sommets.size()-1){ // le dernier trait
         posx2 = ball.posx;
         posy2 = ball.posy; 
         curalpha = alphaInit;
      } else {
         float[] coords = (float[]) sommets.get(s+1);
         posx2 = coords[0];
         posy2 = coords[1];
         curalpha = int(coords[2]);
      }
      float[] coords = (float[]) sommets.get(s);
      posx = coords[0];
      posy = coords[1];
      stroke(255, 255, 255, curalpha);
      line(posx, posy, posx2, posy2);
      noStroke();
      
      //text(sommets.size(), 30, 30);
        
      // blur  
      coords[2] += alphaBlur;
      
      // auto-delete
      if(sommets.size()>30){
        sommets.remove(0);
      }
      
    }
  }
  
  void initLines(){
    curalpha = alphaInit;
    alphaInit = 0;
    while(sommets.size()>0){
      sommets.remove(0);
    }
    float[] coords = {posx, posy, alphaInit};
    sommets.add(coords);
  }
  
}
/*
[ Self - Pong ]
by Gildas P. / http://www.gildasp.fr/playingwithpixels/
*/

class SelfPongBall {
  
  float vitx, vity, vitesse, accel;
  int posx, posy, diam, pposx, pposy;
  ColliderRect collider;
  DrawLines lignes;
  
  SelfPongBall(int _x, int _y){
    posx = _x;
    posy = _y;
    pposx = width/2;
    pposy = height/2;
    vitx = 6;
    vity = 0;
    diam = 15;
    
    vitesse = 6;
    accel = 1.0005;
    
    collider = new ColliderRect(posx, posy, diam, diam);
    lignes = new DrawLines(posx, posy);
  } 
  
  void updateBall(){
    
    // score
    if(posx+30>width && pposx+30<width){ score1++; test_gameover(); }
    if(posx-30<0 && pposx-30>0){ score2++; test_gameover(); }
    
    pposx = posx;
    pposy = posy;
    posx += vitx;
    posy += vity; 
    
    if(!display_intro && !display_youwin){
      vitesse *= accel;
    }
    
    // limites de la balle
    if(posx+diam/2>width){ vitx = -1*abs(vitx); lignes.addLine(posx, posy); }
    if(posx-diam/2<0){ vitx = abs(vitx); lignes.addLine(posx, posy); }
    if(posy+diam/2>height){ vity = -1*abs(vity); lignes.addLine(posx, posy); }
    if(posy-diam/2<0){ vity = abs(vity); lignes.addLine(posx, posy); }
    
    
    // collider de la balle
    collider.posx = posx;
    collider.posy = posy;
    collider.larg = diam;
    collider.haut = diam;
    
    // collisions
    ArrayList colliders = collider.collideRectList(listeColliders);
    if(colliders.size()>0){
       for(int b=0; b<colliders.size(); b++){
         ColliderRect tmp = (ColliderRect) colliders.get(b);
         
         // vecteur unitaire de la collision...
         float[] vecteur = collider.collideRectVector(tmp);
         
         // déformation du vecteur
         float vectx = vecteur[0]*2;
         float vecty = vecteur[1]/1.5;
         float distance = dist(0, 0, vectx, vecty);
         vectx /= distance;
         vecty /= distance; // hop, c'est le vecteur unitaire
         
         // pb il faut atténuer en y et augmenter en x en gardant la même vitesse finale...
         vitx = vectx*vitesse;
         vity = vecty*vitesse;
         
         stroke(255, 153, 0);
         line(posx, posy, posx+vectx*150, posy+vecty*150);
         noStroke();
         
         lignes.addLine(posx, posy);
       }
    }
    
    // bug
    if(abs(vitx) <0.5 && display_youwin == false){       
        float tmp = random(-1, 1);
        if(tmp>0){
          vitx = 2;
        } else {
          vity = -2;
        }
    }
  }
  
  void drawBall(){
    noStroke();
    fill(255, 255, 255);
    ellipse(posx, posy, diam, diam);
    
    //collider.drawCollider();
    
  }
  
  void gameover(){
    
  } 
}
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


