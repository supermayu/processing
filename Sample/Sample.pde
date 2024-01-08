float radiusOuter = 200;
float radiusInner = radiusOuter / 2.5;
int numInnerSpheres = 8; // 内側の球体の数

// 内側の球体の位置情報を保存する配列
PVector[] innerSpheres = new PVector[numInnerSpheres];

// 再帰呼び出しの深さを制御する変数
int recursionDepth = 0;

void setup() {
  size(600, 600, P3D);
  hint(ENABLE_DEPTH_SORT);

  // 初期位置を設定
  for (int i = 0; i < numInnerSpheres; i++) {
    float theta = map(i, 0, numInnerSpheres, 0, TWO_PI);
    float maxOuter = radiusOuter / 1.1;
    float minOuter = radiusOuter / 1.5;
    float x = cos(theta) * random(minOuter,maxOuter);
    float y = sin(theta) * random(minOuter,maxOuter) ;
    float z = 0;
    innerSpheres[i] = new PVector(x, y, z);
  }
}

void draw() {
  background(255);
  lights();

  translate(width / 2, height / 2, 0);

  caliculateRatio();
  drawInnerSpheres(innerSpheres, radiusInner, radiusOuter);
  drawOuterSphere();
  shepreCounter = 0;
}

void drawOuterSphere() {
  blendMode(BLEND);
  noStroke();
  fill(255, 255, 255, 100);
  sphere(radiusOuter);

  //外側の球体の中心に1つの球体
  fill(0,255, 0,100);
  sphere(random(radiusInner));

  pushMatrix();

  //さらにその中に８つの球体
  for (int i = 0; i < innerSpheres.length; i++) {

    float theta = map(i, 0, numInnerSpheres, 0, TWO_PI);
    float maxOuter = radiusInner / 2;
    float minOuter = radiusInner / 4;
    float x = cos(theta) * random(minOuter,maxOuter);
    float y = sin(theta) * random(minOuter,maxOuter);
    float z = 0;

    pushMatrix();
    translate(x, y, z);
    fillByTxRatio(shepreCounter);
    sphere(random(minOuter,maxOuter));
    shepreCounter++;
  }

}
int shepreCounter = 0;

void drawInnerSpheres(PVector[] spheres, float radius, float radiusParent) {
  blendMode(BLEND);
  noStroke();

  pushMatrix();
  translate(0, 0, -radiusParent / 2);

  recursionDepth++; // 再帰呼び出しの深さを増やす

  for (int i = 0; i < spheres.length; i++) {
    float x = spheres[i].x;
    float y = spheres[i].y;
    float z = spheres[i].z;

    pushMatrix();
    translate(x, y, z);
    fillByTxRatio(shepreCounter);
    sphere(random(radius));
    shepreCounter++;

    // 再帰呼び出しで描く小さな球体の位置情報を設定
    PVector[] smallSpheres = new PVector[numInnerSpheres];
    for (int j = 0; j < numInnerSpheres; j++) {
      float smallTheta = map(j, 0, numInnerSpheres, 0, TWO_PI);
      float smallX = cos(smallTheta) * radius / 1.5;
      float smallY = sin(smallTheta) * radius / 1.5;
      float smallZ = 0;
      smallSpheres[j] = new PVector(smallX, smallY, smallZ);
    }

    // 再帰呼び出し
    if (recursionDepth < 2) { // 再帰呼び出しの深さの制限
      drawInnerSpheres(smallSpheres, radius/1.5, radius);
    }

    popMatrix();
  }

  recursionDepth--; // 再帰呼び出しの深さを減らす

  popMatrix();
}
void fillByTxRatio(int shepreNum) {
  float zoraRow = 42 * zora_tx_ratio;
  float pgnRow = 42 * pgn_tx_ratio;
  float baseRow = 42 * base_tx_ratio;
  float opRow = 42 * op_tx_ratio;

  if(shepreNum <= zoraRow){
    fill(128,0, 128,100);//紫
  }else if(shepreNum <= pgnRow){
    fill(0,255, 0,100);//緑
  }else if(shepreNum <= baseRow){
    fill(0,0, 255,100);//青
  }else{
    fill(255,0, 0,100);//赤
  }
}

float total = 0;
float zora_tx_ratio = 0;
float pgn_tx_ratio = 0;
float base_tx_ratio = 0;
float op_tx_ratio = 0;

void caliculateRatio(){
  String[] lines = loadStrings("data.csv");
  int numRows = lines.length;
  float [] txZora = new float[numRows];
  float [] txPgn = new float[numRows];
  float [] txBase = new float[numRows];
  float [] txOp = new float[numRows];

  for (int i = 1; i < numRows; i++) {
    String[] values = split(lines[i], ',');
    txZora[i] = float(values[1]);
    txPgn[i] = float(values[2]);
    txBase[i] = float(values[3]);
    txOp[i] = float(values[4]);
  }

  float sumTxZora = 0;
  float sumTxPgn = 0;
  float sumTxBase = 0;
  float sumTxOp = 0;

  for (int i = 1; i < numRows; i++) {
    sumTxZora += txZora[i];
    sumTxPgn += txPgn[i];
    sumTxBase += txBase[i];
    sumTxOp += txOp[i];
  }

  float total = sumTxZora + sumTxPgn + sumTxBase + sumTxOp;
  zora_tx_ratio = sumTxZora / total;
  pgn_tx_ratio = sumTxPgn / total;
  base_tx_ratio = sumTxBase / total;
  op_tx_ratio = sumTxOp / total;

    float zoraRow = 42 * zora_tx_ratio;
  float pgnRow = 42 * pgn_tx_ratio;
  float baseRow = 42 * base_tx_ratio;
  float opRow = 42 * op_tx_ratio;
}