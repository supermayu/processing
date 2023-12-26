//@param numChildren: 各ノードが持つ子の数
//@param maxLevels: ツリーの最大の深さ
int _numChildren = 3;
int _maxLevels = 5;

Sphere _trunk;

void setup() {
    size(400, 400, P3D);
    background(255);
    noStroke();
    newSphere();
    frameRate(1);
}

void newSphere() {
    _trunk = new Sphere(width/2, height/2, 0, width, 1);
}

//draw関数は実行中常に呼び出され続ける
void draw() {
    background(255);
    lights();
    //((Sphere) _trunk).updateMe(width/2.0 ,height/2.0, 0, width,height);

     ((Sphere) _trunk).drawMe();  

}
