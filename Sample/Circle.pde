class Circle {

    //@param level:木の分岐
    //@param x,y:楕円の中心のx,y座標
    //@param width,height:楕円の幅と高さ
    float level;
    float currentX, currentY;
    float currentWidth, currentHeight;

    //@param nextX,nextY:次の楕円の中心のx,y座標
    //@param nextWidth,nextHeight：次の円の幅と高さ
    float nextX,nextY;
    float nextWidth,nextHeight;

    //@param storkeWeight:描画する線の太さ
    float strokeWeight = 0.5;

    //@param len:現在の円の中心座標から次の円の中心座標までの長さ
    //@param rot:現在の円の中心座標から次の円の中心座標の角度
    float len;
    float rot;


    //@param children: この円の子供を格納する配列
    Circle[] children = new Circle[0];

    //引数：円のx,y座標と幅、高さ
    Circle(float lev, float x, float y, float wid, float hei) {
        level = lev;
        currentX = x;
        currentY = y;
        currentWidth = wid;
        currentHeight = hei;

        updateMe(currentX,currentY,currentWidth,currentHeight);

        if(level < _maxLevels){
            children = new Circle[_numChildren];
            for(int i = 0; i < _numChildren; i++){
                children[i] = new Circle(level+1,nextX,nextY,nextWidth,nextHeight);
            }
        }
    }

    void drawMe() {
        if(level > 1){
            //strokeWeight(strokeWeight);
            //stroke(0, 100);//輪郭線の色
            fill(255, 100);//塗りつぶしの色
            ellipse(currentX, currentY, currentWidth, currentHeight);//x,yの位置に楕円を描画
            //translate(currentX, currentY,50);
            //sphere(nextWidth);
        }
        
        for (int i = 0; i < children.length; ++i) {
            children[i].drawMe();
        }
    }
    
    //円の場所とサイズアップデートするための関数
    void updateMe(float currentX, float currentY, float currentWidth, float currentHeight) {
        
        len = random(currentWidth/2.0);
        rot = random(360);//ランダムじゃないバージョンも試す
        
        float radian =  radians(rot);
        nextX = currentX + (len * cos(radian));//次の円のx座標
        nextY = currentY + (len * sin(radian));//次の円のy座標
        nextWidth = currentWidth / 2;
        nextHeight = currentHeight / 2;
        
        for (int i = 0; i < children.length; i++){
            children[i].updateMe(nextX, nextY,nextWidth,nextHeight);
        }
    }
}

