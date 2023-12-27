int childNum = 0;
ArrayList<Sphere> children = new ArrayList<Sphere>();

class Sphere {

    //@param x,y:楕円の中心のx,y座標
    //@param width:楕円の半径
    float currentX, currentY, currentZ;
    float currentRadius;

    //@param nextX,nextY:次の楕円の中心のx,y座標
    //@param nextWidth：次の円の半径
    float nextX, nextY, nextZ;
    float nextRadius;

    //@param len:現在の円の中心座標から次の円の中心座標までの長さ
    //@param rot:現在の円の中心座標から次の円の中心座標の角度
    float len;
    float rot;

    //各Sphereオブジェクトは独自のlevelを持ち、再帰的な呼び出し時にはそのlevelを引数として渡す
    int level;
    
    //引数：円のx,y座標と半径
    Sphere(float x, float y, float z, float rad, int lev) {

        currentX = x;
        currentY = y;
        currentZ = z;
        currentRadius = rad;
        level = lev;

        updateMe(currentX,currentY,currentZ);

        if(level <= _maxLevels){
            // float lenMax = currentRad/2;
            float lenMax = currentRadius / 2;
            float radMax = currentRadius / 2;

            for(int i = 1; i <= _numChildren; i++){
                Sphere child = new Sphere(nextX, nextY, nextZ, nextRadius, level+1);
                children.add(child);
                childNum++;
            }
        }
    }

    void drawMe() {

        for(int i = 0; i < 31; i++) {
            Sphere currentSphere = children.get(i);
            int lev = currentSphere.level;
            if(lev >= 1){
                pushMatrix();

                
                fill(random(225),random(225), random(225),50);
                Sphere newSphere = new Sphere(currentSphere.nextX, currentSphere.nextY, currentSphere.nextZ, currentSphere.nextRadius, lev);
                translate(currentSphere.nextX, currentSphere.nextY,currentSphere.nextZ);
                sphere(currentSphere.nextRadius);
                popMatrix();
            }
        }
       /*  pushMatrix();
        fill(0,0,0);
        sphere(currentRadius);
        popMatrix();*/
    }
    
    //円の場所とサイズアップデートするための関数
    void updateMe(float currentX, float currentY, float currentZ) {
        float lenMax = 150;
        float radMax = 150;
        if(currentRadius >= 50) {
            lenMax = currentRadius*1.7;
            radMax = currentRadius/2;
        }

        len = random(lenMax);
        rot = random(360);
        
        float radian =  radians(rot);
        nextX = currentX + (len * cos(radian));
        nextY = currentY + (len * sin(radian));
        nextZ = currentZ + (10 +  sin(radian));
        nextRadius = random(radMax);
       
       /* for (int i = 0; i < 362; i++){
            children.get(i).updateMe(nextX, nextY, nextZ);

        }*/
    }
}