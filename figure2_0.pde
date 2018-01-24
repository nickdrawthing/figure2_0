float xC;
float baseY;
float abc = 0;

// this version uses Bones and Nodes 

// Skeleton Bones
Bone bRoot, bTop, bPubic, bBackLow, bBackHigh, bNeck, bHead, bShoulder, bElbow, bWrist, bKnuckles, bHand, 
    bHip, bKnee, bAnkle, bFoot;
    
// Geometry Nodes
Node top, pubic, groin, neckBase, shoulder, hip, knee, thigh, inKnee, foot, ankle, outAnkle, heel, calf, outCalf, 
    waist, wrist, elbow, inElbow, deltoidEnd, deltoid, hand, thumbJoin, headWid, neckWid, jaw, chin, eye, 
    mouthCorner, mouthC, cup, sPlexus, navel, inCup;

void setup(){
  size(960,1080);
  xC = width/2;
  baseY = height * .8;
 
  
  bRoot = new Bone(0,0, "bRoot");
  bTop = new Bone(bRoot.x,random(500,800),bRoot,"bTop");
  bPubic = new Bone(bRoot.x,scaleAvg(bRoot.y,bTop.y,random(0.4,0.6)),bRoot,"bPubic");
  bNeck = new Bone(bRoot.x,scaleAvg(bPubic.y,bTop.y,random(0.5,0.7)),"bNeck");
  bBackLow = new Bone(bRoot.x,scaleAvg(bPubic.y,bNeck.y,random(.2,.3)),bPubic,"bBackLow");
  bBackHigh = new Bone(bRoot.x,scaleAvg(bBackLow.y,bNeck.y,random(.2,.4)),bBackLow,"bBackHigh");
  bHead = new Bone(bRoot.x,scaleAvg(bNeck.y,bTop.y,random(.1,.2)),bNeck,"bHead");
  bShoulder = new Bone(bRoot.x+(scaleAvg(bRoot.y,bTop.y,random(.1,.2))),bNeck.y+(bPubic.y*random(-.2,.05)),bNeck,"bShoulder");
  bHip = new Bone(bRoot.x+(scaleAvg(bRoot.y,bTop.y,random(.1,.2))),bPubic.y+((bTop.y-bRoot.y)*random(-.1,.1)),bPubic,"bHip");
  bFoot = new Bone(scaleAvg(bHip.x,bShoulder.x,random(-.2,1.2))+((bTop.y-bRoot.y)*.05*random(-1,.5)),bRoot.y,bHip,"bFoot");
  bAnkle = new Bone(scaleAvg(bFoot.x,bRoot.x,random(.05,.15)),scaleAvg(bFoot.y,bHip.y,random(.05,.15)),bFoot,"bAnkle");
  bKnee = new Bone(scaleAvg(bHip.x,bAnkle.x,random(0,1)),scaleAvg(bHip.y,bAnkle.y,random(.45,.55)),bHip,"bKnee");
  bWrist = new Bone(scaleAvg(bRoot.x,bHip.x,random(1,1.5)),scaleAvg(bKnee.y,bHip.y,random(.7,.9)),"bWrist");
  bElbow = new Bone(scaleAvg(bWrist.x,bShoulder.x,random(.15,.5)),scaleAvg(bShoulder.y,bWrist.y,random(.4,.5)),bShoulder,"bElbow");
  /*
  bHand = new Bone(,,"");
  //*/
  bNeck.assignParent(bBackHigh);
  bAnkle.assignParent(bKnee);
  bFoot.assignParent(bAnkle);
  bWrist.assignParent(bElbow);
  
  bRoot.x = xC;
  bRoot.y = baseY;
  
  //bRoot.place();  
}

void draw(){
  //clear();
  background(127);
  bRoot.place();
  abc ++;
  ellipse(width/2+(randNoise(abc)*(width/2)),height/2,5,5);
}

float avg(float a, float b){
  return (a+b)/2; 
}

float scaleAvg(float a, float b, float z){
  return a+(b-a)*z; 
}

public Bone[] bPush(Bone[] array, Bone push) {
    Bone[] longer = new Bone[array.length + 1];
    System.arraycopy(array, 0, longer, 0, array.length);
    longer[array.length] = push;
    return longer;
}

public Node[] nPush(Node[] array, Node push) {
    Node[] longer = new Node[array.length + 1];
    System.arraycopy(array, 0, longer, 0, array.length);
    longer[array.length] = push;
    return longer;
}

float randNoise(float a){
  //returns a value between 0 and 1
  return (((sin(a)+1)/2)+((sin(a/3)+1)/2)+((sin(a/7)+1)/2)+((sin(a/9)+1)/2))/4;
    
}

class Vector {
  float x, y, z;
  Vector (float a, float b, float c, String s) {
    x = a;
    y = b;
    z = c;
    ellipse(x,y,10,10);
    ellipse(-x,y,10,10);
    text(s, x+10, y+4);
  }
}

class Bone {
  float x,y,distP,currX,currY,angle,currAngle;
  //float angle;
  Bone parent, grandparent;
  Bone bChildren[] = new Bone[0];
  Node nChildren[] = new Node[0];
  String name;
  
  // give it a parent when instantiated
  Bone (float a, float b, Bone p, String n){
    x = a;
    y = b;
    currX = x;
    currY = y;
    assignParent(p);
    name = n;
  }
  
  // or instantiate without, and assign one later with assignParent()
  Bone (float a, float b, String n){
    x = a;
    y = b;
    currX = x;
    currY = y;
    angle = 0;
    currAngle = angle;
    parent = null;
    name = n;
  }
  void assignParent (Bone p){
    if (parent != null){ 
      parent.removeChild(this);
    }
    for (int i = 0; i < bChildren.length; i++){
      bChildren[i].assignParent(this);  
    }
    parent = p;
    parent.receiveChild(this);
    distP = dist(x,y,parent.x,parent.y);
    double xDiff = parent.x - x;
    double yDiff = parent.y - y;
    double ang = Math.atan2(yDiff,xDiff);
    angle = (float)ang;
    currAngle = angle;
    grandparent = parent;
    while (grandparent.parent != null) {
      grandparent = grandparent.parent;
    }
  }
  
  void receiveChild(Bone a){
    bChildren = bPush(bChildren,a);
  }
  void receiveChild(Node a){
    nChildren = nPush(nChildren,a);
  }
  
  void removeChild(Bone a){
    Bone shorter[] = new Bone[bChildren.length-1];
    int assigned = 0;
    for (int i = 0; i < bChildren.length; i++){
      if (bChildren[i] != a){
        shorter[assigned] = bChildren[i];
        assigned++;
      }
    }
    bChildren = shorter;
  }
  void removeChild(Node a){
    Node shorter[] = new Node[nChildren.length-1];
    int assigned = 0;
    for (int i = 0; i < nChildren.length; i++){
      if (nChildren[i] != a){
        shorter[assigned] = nChildren[i];
        assigned++;
      }
    }
    nChildren = shorter;
  }
  
  void place(boolean t){
    doPlace(t);
  }
  
  void place(){
    doPlace(true);   
  }
  
  void doPlace(boolean t){
    if (parent != null){
      currAngle = angle + (parent.currAngle - parent.angle);
      currX = parent.currX+(distP*cos(currAngle));
      currY = parent.currY+(distP*sin(currAngle));
      if (t) line(currX,currY,parent.currX,parent.currY);
    } else {
      //currAngle = angle;
      currX = x;
      currY = y;
    }
    for (int i = 0; i < bChildren.length; i++){
      bChildren[i].place(t);
    }
    if (t){
      int i;
      ellipse(currX,currY,10,10);
      text(name, currX+4, currY+4);
      for (i = 0; i < bChildren.length; i++){
        text(bChildren[i].name, currX+20, currY+20+(i*20));
      }
      if (grandparent != null) text(grandparent.name, currX+36,currY+20+((i+1)*20));
    }
  }
  
  void drawDot(float offX, float offY){
    ellipse(x+offX,y+offY,5,5);
    text(name, x+offX+4, y+offY+4);
  }
}

class Node {
  float x,y,distP,currX,currY;
  double angle, currAngle;
  Bone parent;
  String name;
  Node (float a, float b, Bone p, String n){
    x = a;
    y = b;
    currX = x;
    currY = y;
    parent = p;
    parent.receiveChild(this);
    distP = dist(x,y,parent.x,parent.y);
    double xDiff = parent.x - x;
    double yDiff = parent.y - y;
    double ang = Math.atan2(yDiff,xDiff);
    angle = (float)ang;
    currAngle = angle;
    name = n;
  }
  // or instantiate without, and assign one later with assignParent()
  Node (float a, float b, String n){
    x = a;
    y = b;
    currX = x;
    currY = y;
    angle = 0;
    currAngle = angle;
    parent = null;
    name = n;
  }
  void assignParent (Bone p){
    parent = p;
    parent.receiveChild(this);
    distP = dist(x,y,parent.x,parent.y);
    double xDiff = parent.x - x;
    double yDiff = parent.y - y;
    double ang = Math.atan2(yDiff,xDiff);
    angle = (float)ang;
    currAngle = angle;    
  }
}