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
