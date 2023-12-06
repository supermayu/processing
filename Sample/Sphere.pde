int childNum = 0;
ArrayList<Sphere> children = new ArrayList<Sphere>();

class Sphere {

    //@param level:木の分岐の階層
    //@param x,y:楕円の中心のx,y座標
    //@param width,height:楕円の幅と高さ
    float currentX, currentY, currentZ;
    float currentWidth, currentHeight;

    //@param nextX,nextY:次の楕円の中心のx,y座標
    //@param nextWidth,nextHeight：次の円の幅と高さ
    float nextX, nextY, nextZ;
    float nextWidth,nextHeight;

    //@param len:現在の円の中心座標から次の円の中心座標までの長さ
    //@param rot:現在の円の中心座標から次の円の中心座標の角度
    float len;
    float rot;

    //各Sphereオブジェクトは独自のlevelを持ち、再帰的な呼び出し時にはそのlevelを引数として渡す
    int level;
    
    //引数：円のx,y座標と幅、高さ
    Sphere(float x, float y, float z, float wid, float hei, int lev) {
        currentX = x;
        currentY = y;
        currentZ = z;
        currentWidth = wid;
        currentHeight = hei;
        level = lev;

        updateMe(currentX,currentY,currentZ,currentWidth,currentHeight);

        if(level <= _maxLevels){
            for(int i = 1; i <= _numChildren; i++){
                Sphere child = new Sphere(nextX, nextY, nextZ, nextWidth, nextHeight, level+1);
                //println(nextWidth);
                children.add(child);
                //println("level: " + lev + ", childNum: " + childNum);ここまではOK
                childNum++;
            }
        }
    }

    void drawMe() {
        for(int i = 0; i < 362; i++) {
            Sphere currentSphere = children.get(i);
            int lev = children.get(i).level;
            if(lev >= 1){
                //stroke(0, 100);
                fill(random(225),random(225),random(225), 50);//塗りつぶしの色
                Sphere newSphere = new Sphere(currentSphere.nextX, currentSphere.nextY, currentSphere.nextZ, currentSphere.nextWidth, currentSphere.nextHeight, lev);
                translate(newSphere.nextX, newSphere.nextY,newSphere.nextZ);
                sphere(newSphere.nextWidth);
                println(newSphere.nextWidth);
            }
        }
    }
    
    //円の場所とサイズアップデートするための関数
    void updateMe(float currentX, float currentY, float currentZ, float currentWidth, float currentHeight) {
        
        len = random(120);
        rot = random(360);
        
        float radian =  radians(rot);
        nextX = currentX + (len * cos(radian));//次の球のx座標
        nextY = currentY + (len * sin(radian));//次の球のy座標
        nextZ = currentZ + (len * tan(radian));//次の球のz座標
        nextWidth = random(100);
        nextHeight = random(100);
        
        /*for (int i = 0; i < children.length; i++){
            children[i].updateMe(nextX, nextY, nextZ, nextWidth,nextHeight);

        }*/
    }
}

