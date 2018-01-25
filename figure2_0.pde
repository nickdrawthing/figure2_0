float xC;
float baseY;

// this version uses Bones and Nodes 

// Skeleton Bones
Bone bRoot, bTop, bPubic, bBackLow, bBackHigh, bNeck, bHead, bShoulder, bElbow, bWrist, bKnuckles, bHand, 
    bHip, bKnee, bAnkle, bFoot;
    
// Geometry Nodes
Node top, pubic, groin, neckBase, shoulder, hip, knee, thigh, inKnee, foot, ankle, outAnkle, heel, calf, outCalf, 
    waist, wrist, elbow, inElbow, deltoidEnd, deltoid, hand, thumbJoin, headWid, neckWid, jaw, chin, eye, 
    mouthCorner, mouthC, cup, sPlexus, navel, inCup, ribs, neckTop;

void setup(){
  size(960,1080);
  xC = width/2;
  baseY = height * .8;
 
  //      POSITION THE BONES
  
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

  bNeck.assignParent(bBackHigh);
  bAnkle.assignParent(bKnee);
  bFoot.assignParent(bAnkle);
  bWrist.assignParent(bElbow);
  bRoot.assignParent(bRoot);
  bTop.assignParent(bHead);
  
  bPubic.setAngles(.1,-.1);
  bKnee.setAngles(1,-.5);
  bAnkle.setAngles(-.5,-.1);
  bBackLow.setAngles(0,.1);
  bBackHigh.setAngles(-.5,.5);
  bNeck.setAngles(.1,-.1);
  bShoulder.setAngles(0,.5);
  bElbow.setAngles(-1,PI);
  bWrist.setAngles(0,.4);
  bHead.setAngles(-1,1);
  bTop.setAngles(.5,-.5);
  bFoot.setAngles(-.5,1);
  
  //      POSITION THE ART NODES
  //*
  top = new Node(bTop.x,bTop.y,bTop,"top");
  pubic = new Node(bPubic.x,bPubic.y,bPubic,"pubic");
  groin = new Node(bRoot.x,scaleAvg(pubic.y,bRoot.y,random(0.5,0.8)),bPubic,"groin");
  neckBase = new Node(bNeck.x,bNeck.y,bNeck,"neckBase");
  shoulder = new Node(bShoulder.x,bShoulder.y,bShoulder,"shoulder");
  hip = new Node(bHip.x,bHip.y,bHip,"hip");
  knee = new Node(bKnee.x,bKnee.y,bKnee,"knee");
  thigh = new Node(scaleAvg(hip.x,avg(hip.x,knee.x),random(-.2,1)),avg(hip.y,knee.y),bKnee,"thigh");
  inKnee = new Node(scaleAvg(knee.x,bRoot.x,random(0.6,.8)),knee.y+random(5,10),bKnee,"inKnee");
  foot = new Node(bFoot.x,bFoot.y,bFoot,"foot");
  ankle = new Node(bAnkle.x,bAnkle.y,bAnkle,"ankle");
  outAnkle = new Node(avg(ankle.x,foot.x),scaleAvg(ankle.y,foot.y,random(0.25,0.5)),bAnkle,"outAnkle");
  heel = new Node(ankle.x,foot.y,bFoot,"heel");
  calf = new Node(avg(inKnee.x,bRoot.x),avg(inKnee.y,ankle.y),bAnkle,"calf");
  outCalf = new Node(knee.x,avg(inKnee.y,calf.y),bAnkle,"outCalf");
  waist = new Node(scaleAvg(shoulder.x,hip.x,random(-.25,1.25)),scaleAvg(shoulder.y,hip.y,0.7),bBackLow,"waist");
  ribs = new Node(scaleAvg(waist.x,shoulder.x,.3),scaleAvg(waist.y,shoulder.y,.4),bBackHigh,"ribs");
  wrist = new Node(bWrist.x,bWrist.y,bWrist,"wrist");
  elbow = new Node(bElbow.x,bElbow.y,bElbow,"elbow");
  inElbow = new Node(scaleAvg(shoulder.x,wrist.x,0.3),scaleAvg(shoulder.y,wrist.y,0.55),bElbow,"inElbow");
  deltoidEnd = new Node(avg(shoulder.x,elbow.x),avg(shoulder.y,elbow.y),bElbow,"deltoidEnd");
  deltoid = new Node(scaleAvg(shoulder.x,deltoidEnd.x,random(.5,.7)),scaleAvg(shoulder.y,deltoidEnd.y,random(.3,.5)),bShoulder,"deltoid");
  //hand = new Node(,,,"");
  //thumbJoin = new Node(,,,"");
  headWid = new Node(scaleAvg(bRoot.y,top.y,random(.1,.12)),scaleAvg(top.y,neckBase.y,random(.1,.2)),bTop,"headWid");
  neckWid = new Node(max(scaleAvg(headWid.x,bRoot.x,random(0.05,0.2)),shoulder.x),avg(shoulder.y,neckBase.y),bShoulder,"neckWid");
  jaw = new Node(scaleAvg(neckWid.x,headWid.x,random(0,1.05)),scaleAvg(top.y,neckBase.y,random(0.6,0.8)),bHead,"jaw");
  neckTop = new Node(scaleAvg(bRoot.x,jaw.x,random(.5,1)),jaw.y,bHead,"neckTop");
  chin = new Node(bRoot.x,avg(jaw.y,neckBase.y),bHead,"chin");
  eye = new Node(scaleAvg(headWid.x,bRoot.x,random(0.4,0.6)),scaleAvg(top.y,chin.y,random(0.4,0.6)),bTop,"eye");
  mouthCorner = new Node(scaleAvg(jaw.x,bRoot.x,random(0,.5)),scaleAvg(eye.y,jaw.y,random(.4,.9)),bHead,"mouthCorner");
  mouthC = new Node(bRoot.x,scaleAvg(mouthCorner.y,chin.y,random(-.2,.5)),bHead,"mouthC");
  cup = new Node(scaleAvg(shoulder.x,neckWid.x,random(0.4,0.6)),scaleAvg(shoulder.y,waist.y,random(0.4,0.7)),bBackHigh,"cup");
  sPlexus = new Node(bRoot.x,,,"");
  navel = new Node(,,,"");
  inCup = new Node(,,,"");
  //*/
  //      GET
  
  
  
  bRoot.x = xC;
  bRoot.y = baseY;
}

void draw(){
  //clear();
  background(127);
  bPubic.rotation();
  bKnee.rotation(1);
  bAnkle.rotation(1);
  bBackLow.rotation();
  bBackHigh.rotation();
  bNeck.rotation();
  bShoulder.rotation();
  bElbow.rotation(.5);
  bWrist.rotation();
  bHead.rotation();
  bTop.rotation();
  bFoot.rotation();
  bRoot.place();
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

float randNoise(float a, int b, int c){
  //returns a value between 0 and 1
  //return (((sin(a)+1)/2)+((sin(a/3)+1)/2)+((sin(a/7)+1)/2)+((sin(a/9)+1)/2))/4;
  float retVal = 0;
  for (int i = 1; i < b+1; i++){
    retVal += sin(a/(i*c));  
  }
  retVal /= b;
  return retVal;  
}

void tri(Node a, Node b, Node c){
  triangle(a.x,a.y,b.x,b.y,c.x,c.y);
  if (a.sibling != null) a = a.sibling;
  if (b.sibling != null) b = b.sibling;
  if (c.sibling != null) c = c.sibling;
  triangle(a.x,a.y,b.x,b.y,c.x,c.y);
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
  float x,y,distP,currX,currY,angle,currAngle,maxAngle = 0,minAngle = 0,rotation = 0,ticker=random(10);
  Bone parent, grandparent, sibling;
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
    if (x > 0){
      createSibling();  
    }
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
    if (x > 0){
      createSibling();  
    }
  }
  
  void createSibling(){
    if (parent != null){
      Bone p = parent;
      if (parent.sibling != null) p = parent.sibling;
      sibling = new Bone(-x,y,p,name);
    }else{
      sibling = new Bone(-x,y,name);
    }
  }
  
  void assignParent (Bone p){
    if (p == this){
      parent = null;
    } else {
      if (parent != null){ 
        parent.removeChild(this);
      }
      parent = p;
      parent.receiveChild(this);
      if (sibling != null){
        Bone q = parent;
        if (q.sibling != null) q = q.sibling;
        sibling.assignParent(q);
      }
      grandparent = parent;
      while (grandparent.parent != null) {
        grandparent = grandparent.parent;
      }      
      distP = dist(x,y,parent.x,parent.y);
      double xDiff = parent.x - x;
      double yDiff = parent.y - y;
      double ang = Math.atan2(yDiff,xDiff);
      angle = (float)ang;
      currAngle = angle;
      }
    for (int i = 0; i < bChildren.length; i++){    
      bChildren[i].assignParent(this);  
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
  
  void setAngles(float a, float b){
    maxAngle = a;
    minAngle = b;
    if (sibling != null){
      sibling.maxAngle = -a;
      sibling.minAngle = -b;
    }
  }
  
  void rotation(){
    rotation(0);
  }
  
  void rotation(float a){
    ticker += random(1)+a;
    rotation = scaleAvg(minAngle,maxAngle,(randNoise(ticker,7,5)+1)/2);
    if (sibling != null) sibling.rotation(a);
  }
  
  void place(boolean t){
    doPlace(t);
  }
  
  void place(){
    doPlace(true);   
  }
  
  void doPlace(boolean t){
    if (parent != null){
      currAngle = angle + (parent.currAngle - parent.angle) + rotation;
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
      if (grandparent != null) text(grandparent.name, currX+36,currY+20+((i)*20));
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
  Node sibling = null;
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
    
    if (x < 0) {
      Bone par = parent;
      if (par.sibling != null) par = par.sibling;
      sibling = new Node (-x,y,par,name);
    }
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