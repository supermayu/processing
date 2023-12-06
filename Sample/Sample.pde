//@param numChildren: 各ノードが持つ子の数
//@param maxLevels: ツリーの最大の深さ
int _numChildren = 5;
int _maxLevels = 5;

Circle _trunk;

void setup() {
    size(400, 400, P3D);
    background(255);
    noFill();
    smooth();
    //noStroke();
    newCircle();
}

void newCircle() {
    _trunk = new Circle(1,width/2,height/2,0,width,height);
}

void draw() {
    background(255);
    //lights();
     ((Circle) _trunk).updateMe(width/2.0 ,height/2.0,0,width,height);
     ((Circle) _trunk).drawMe();
}