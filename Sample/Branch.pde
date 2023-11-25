class Branch {

    //@param level:木の分岐の階層
    //@param x,y:枝の始点の座標
    //@param x,y:枝の終点の座標
    float level;
    float x, y;
    float endx,endy;

    //@param len:枝の長さ
    //@param rot:枝の回転角度
    float len;
    float rot;

    //@param children: この枝の子供を格納する配列
    Branch[] children = new Branch[0];

    Branch(float lev, float ex, float why) {
        level = lev;

        len = 100;
        rot = random(360);

        updateMe(ex, why);

        if(level < _maxLevels) {
            children = new Branch[_numChildren];
            for(int x = 0; x < _numChildren; x++) {
                children[x] = new  Branch(level+1, endx, endy);
            }
        }
    }

    void drawMe() {
    if(level > 1){
        strokeWeight(3);
        stroke(0, 100);
        fill(255, 100);
        line(x, y, endx, endy);
        ellipse(endx, endy, len/12, len/12);
    }
    for (int i = 0; i < children.length; ++i) {
        children[i].drawMe();
    }
}

void updateMe(float ex, float why) {
    x = ex;
    y = why;

    float radian =  radians(rot);
    endx = x + (len * cos(radian));
    endy = y + (len * sin(radian));

    for (int i = 0; i < children.length; i++){
        children[i].updateMe(endx, endy);
    }
}
}

