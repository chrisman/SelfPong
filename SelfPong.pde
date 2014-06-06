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
