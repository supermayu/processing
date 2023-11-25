//@param numChildren: 各ノードが持つ子の数
//@param maxLevels: ツリーの最大の深さ
int _numChildren = 5;
int _maxLevels = 5;

Branch _trunk;

void setup() {
    size(750, 500);
    background(255);
    noFill();
    smooth();
    newTree();    
}

void newTree() {
    _trunk = new Branch(1,width/2,height/2);
}

void draw() {
    background(255);
     ((Branch) _trunk).updateMe(width/2.0 ,height/2.0);
     ((Branch) _trunk).drawMe();
}


