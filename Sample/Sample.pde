//@param numChildren: 各ノードが持つ子の数
//@param maxLevels: ツリーの最大の深さ
int _numChildren = 3;
int _maxLevels = 5;

Sphere _trunk;

String[] lines;
float[] txZora, txPgn, txBase, txOp;


void setup() {
    size(400, 400, P3D);

    calculateTotals();
     
    noStroke();
    newSphere();
    frameRate(1);
}

void newSphere() {
    _trunk = new Sphere(0, 0, 0, 400, 1);
}

//draw関数は実行中常に呼び出され続ける
void draw() {
    background(255);
    lights();
    //((Sphere) _trunk).updateMe(width/2.0 ,height/2.0, 0, width,height);
    translate(width / 2, height / 2); 
     ((Sphere) _trunk).drawMe();  
}

//以下、トランザクション数の計算
void calculateTotals() {
    lines = loadStrings("transaction.csv");
    int numRows = lines.length;
    txZora = new float[numRows];
    txPgn = new float[numRows];
    txBase = new float[numRows];
    txOp = new float[numRows];

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

    for (int i = 1; i < txZora.length; i++) {
        sumTxZora += txZora[i];
        sumTxPgn += txPgn[i];
        sumTxBase += txBase[i];
        sumTxOp += txOp[i];
    }

    float total = sumTxZora + sumTxPgn + sumTxBase + sumTxOp;

    println("Total tx_zora: " + sumTxZora);
    println("Total tx_pgn: " + sumTxPgn);
    println("Total tx_base: " + sumTxBase);
    println("Total tx_op: " + sumTxOp);
    println("Total:" + total);

    println("Ratio tx_zora: " + sumTxZora / total * 100+ "%");
    println("Ratio tx_pgn: " + sumTxPgn / total * 100+ "%");
    println("Ratio tx_base: " + sumTxBase / total * 100+ "%");
    println("Ratio tx_op: " + sumTxOp / total * 100+ "%");
}

