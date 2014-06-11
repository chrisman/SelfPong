class GameHelper {

    ArrayList<Platform> platforms;
    SelfPongBall ball;

    GameHelper() {
    }

    void addPlatform(int x, int y, int width, int length, char axisofliberty) {
        platforms.add(new Platform(x, y, width, length, axisofliberty));
        return;
    }

    void addBall(int x, int y, int diam, String imgsrc) {
        ball = new SelfPongBall(x, y, diam, imgsrc);
        return;
    }

    void getInput() {
    }

    void update() {
    }

    void draw() {
    }

}
