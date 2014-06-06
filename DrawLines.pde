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
