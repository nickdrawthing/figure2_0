boolean saveImg = false;
float xC;
float baseY;
float lowY = 0;
float lowYX = 0;
float xMomentum = 0;
float yMomentum = 0;
float xMin = 1000;
float xMax = 0;
color skin = color (random(100,200),random(50,150),random(50,150));
color shadow = color (random(0,50),random(0,100),random(0,100),50);
int jkl = 0;

// this version uses Bones and Nodes 

// Skeleton Bones
Bone bRoot, bTop, bPubic, bBackLow, bBackHigh, bNeck, bHead, bShoulder, bElbow, bWrist, bKnuckles, bHand, 
    bHip, bKnee, bAnkle, bFoot;
    
// Geometry Nodes
Node top, pubic, groin, neckBase, shoulder, hip, knee, thigh, inKnee, foot, ankle, outAnkle, heel, calf, outCalf, 
    waist, wrist, elbow, inElbow, deltoidEnd, deltoid, hand, thumbJoin, headWid, neckWid, jaw, chin, eye, 
    mouthCorner, mouthC, cup, sPlexus, navel, inCup, ribs, neckTop, ear, armpit, cupLow, inCupLow, inThigh;

void setup(){
  size(960,1080);
  xC = width/2;
  baseY = height * .8;
 
  //      POSITION THE BONES
  
  bRoot = new Bone(0,0, "bRoot");
  bTop = new Bone(bRoot.x,random(500,800),bRoot,"bTop");
  bPubic = new Bone(bRoot.x,scaleAvg(bRoot.y,bTop.y,random(0.3,0.6)),bRoot,"bPubic");
  bNeck = new Bone(bRoot.x,scaleAvg(bPubic.y,bTop.y,random(0.4,0.8)),"bNeck");
  bBackLow = new Bone(bRoot.x,scaleAvg(bPubic.y,bNeck.y,random(.2,.3)),bPubic,"bBackLow");
  bBackHigh = new Bone(bRoot.x,scaleAvg(bBackLow.y,bNeck.y,random(.2,.4)),bBackLow,"bBackHigh");
  bHead = new Bone(bRoot.x,scaleAvg(bNeck.y,bTop.y,random(.1,.2)),bNeck,"bHead");
  bShoulder = new Bone(bRoot.x+(scaleAvg(bRoot.y,bTop.y,random(.075,.225))),scaleAvg(bNeck.y,bPubic.y,random(.05,.4)),bNeck,"bShoulder");
  bHip = new Bone(bRoot.x+(scaleAvg(bRoot.y,bTop.y,random(.075,.225))),bPubic.y+((bTop.y-bRoot.y)*random(.1)),bPubic,"bHip");
  bFoot = new Bone(scaleAvg(bHip.x,bShoulder.x,random(-.2,1.2))+((bTop.y-bRoot.y)*.05*random(-1,.5)),bRoot.y,bHip,"bFoot");
  bAnkle = new Bone(scaleAvg(bFoot.x,bRoot.x,random(.05,.15)),scaleAvg(bFoot.y,bHip.y,random(.05,.15)),bFoot,"bAnkle");
  bKnee = new Bone(scaleAvg(bRoot.x,bHip.x,random(0.8,1)),scaleAvg(bHip.y,bAnkle.y,random(.45,.55)),bHip,"bKnee");
  bWrist = new Bone(scaleAvg(bRoot.x,bHip.x,random(1,1.5)),scaleAvg(bKnee.y,bHip.y,random(.7,.9)),"bWrist");
  bElbow = new Bone(scaleAvg(bWrist.x,bShoulder.x,random(.15,.5)),scaleAvg(bShoulder.y,bWrist.y,random(.4,.5)),bShoulder,"bElbow");

  bNeck.assignParent(bBackHigh);
  bAnkle.assignParent(bKnee);
  bFoot.assignParent(bAnkle);
  bWrist.assignParent(bElbow);
  bRoot.assignParent(bRoot);
  bTop.assignParent(bHead);
  
  bPubic.setAngles(.1,-.1);
  bKnee.setAngles(random(1.5),random(-.6,0));
  bAnkle.setAngles(random(-2,-.5),0);
  bBackLow.setAngles(0,.1);
  bBackHigh.setAngles(random(-1,0),random(0,1));
  bNeck.setAngles(.1,-.1);
  bShoulder.setAngles(0,.5);
  bElbow.setAngles(0,random(-PI/2,PI));
  bWrist.setAngles(1,-bElbow.maxAngle+random(-.5,.5));
  bHead.setAngles(-1,1);
  bTop.setAngles(1,-1);
  bFoot.setAngles(-1,1);
  
  //      POSITION THE ART NODES
  //*
  top = new Node(bTop.x,bTop.y,bTop,"top");
  pubic = new Node(bPubic.x,bPubic.y,bPubic,"pubic");
  groin = new Node(bRoot.x,scaleAvg(bRoot.y,pubic.y,random(0.8,0.9)),bPubic,"groin");
  neckBase = new Node(bNeck.x,bNeck.y,bNeck,"neckBase");
  shoulder = new Node(bShoulder.x,bShoulder.y,bShoulder,"shoulder");
  hip = new Node(bHip.x,bHip.y,bHip,"hip");
  knee = new Node(bKnee.x,bKnee.y,bKnee,"knee");
  thigh = new Node(scaleAvg(hip.x,avg(hip.x,knee.x),random(-.2,1)),avg(hip.y,knee.y),bKnee,"thigh");
  inKnee = new Node(scaleAvg(knee.x,bRoot.x,random(0.6,.8)),knee.y+random(5,10),bKnee,"inKnee");
  foot = new Node(scaleAvg(bRoot.x,bFoot.x,random(1.5,2)),bFoot.y,bFoot,"foot");
  ankle = new Node(bAnkle.x,bAnkle.y,bAnkle,"ankle");
  outAnkle = new Node(avg(ankle.x,foot.x),scaleAvg(ankle.y,foot.y,random(0.25,0.5)),bFoot,"outAnkle");
  heel = new Node(ankle.x,bRoot.y,bFoot,"heel");
  calf = new Node(scaleAvg(inKnee.x,bRoot.x,random(.3,.7)),avg(inKnee.y,ankle.y),bAnkle,"calf");
  outCalf = new Node(knee.x,avg(inKnee.y,calf.y),bKnee,"outCalf");
  waist = new Node(avg(shoulder.x,hip.x)+random(-10,10),scaleAvg(shoulder.y,hip.y,0.7),bBackLow,"waist");
  ribs = new Node(scaleAvg(waist.x,shoulder.x,.3),scaleAvg(waist.y,shoulder.y,.4),bBackHigh,"ribs");
  armpit = new Node(ribs.x,avg(shoulder.y,ribs.y),bBackHigh,"armpit");
  wrist = new Node(bWrist.x,bWrist.y,bWrist,"wrist");
  elbow = new Node(bElbow.x,bElbow.y,bElbow,"elbow");
  inElbow = new Node(elbow.x-20,elbow.y,bWrist,"inElbow");
  deltoidEnd = new Node(avg(shoulder.x,elbow.x),avg(shoulder.y,elbow.y),bElbow,"deltoidEnd");
  deltoid = new Node(scaleAvg(shoulder.x,deltoidEnd.x,random(.5,.7)),scaleAvg(shoulder.y,deltoidEnd.y,random(.3,.5)),bElbow,"deltoid");
  //hand = new Node(,,,"");
  //thumbJoin = new Node(,,,"");
  headWid = new Node(scaleAvg(bRoot.y,top.y,random(.02,.07)),scaleAvg(top.y,neckBase.y,random(.1,.2)),bTop,"headWid");
  neckWid = new Node(min(scaleAvg(headWid.x,bRoot.x,random(0,.5)),shoulder.x),avg(shoulder.y,neckBase.y),bShoulder,"neckWid");
  jaw = new Node(scaleAvg(neckWid.x,headWid.x,random(0,1)),scaleAvg(top.y,neckBase.y,random(0.7,0.8)),bTop,"jaw");
  neckTop = new Node(scaleAvg(bRoot.x,neckWid.x,random(.5,1)),jaw.y,bTop,"neckTop");
  chin = new Node(bRoot.x,avg(jaw.y,neckBase.y),bTop,"chin");
  eye = new Node(scaleAvg(headWid.x,bRoot.x,random(0.4,0.6)),scaleAvg(top.y,chin.y,random(0.4,0.6)),bTop,"eye");
  ear = new Node(avg(headWid.x,jaw.x)+random(5,10),eye.y,bTop,"ear");
  mouthCorner = new Node(scaleAvg(jaw.x,bRoot.x,random(0,.5)),scaleAvg(eye.y,jaw.y,random(.4,.9)),bHead,"mouthCorner");
  mouthC = new Node(bRoot.x,scaleAvg(mouthCorner.y,chin.y,random(-.2,.5)),bHead,"mouthC");
  cup = new Node(scaleAvg(shoulder.x,neckWid.x,random(0.4,0.6)),scaleAvg(shoulder.y,waist.y,random(0.4,0.7)),bBackHigh,"cup");
  cupLow = new Node(cup.x,cup.y-random(40),bBackHigh,"cupLow");
  sPlexus = new Node(bRoot.x,scaleAvg(pubic.y,neckBase.y,random(0.5,0.65)),bBackHigh,"sPlexus");
  navel = new Node(bRoot.x,avg(sPlexus.y,pubic.y),bBackLow,"navel");
  inCup = new Node(scaleAvg(cup.x,sPlexus.x,random(.2,.8)),scaleAvg(navel.y,sPlexus.y,random(.2,.8)),bBackHigh,"inCup");
  inCupLow = new Node(inCup.x,inCup.y-random(20),bBackHigh,"inCupLow");
  inThigh = new Node(avg(pubic.x,hip.x),avg(groin.y,hip.y),bHip,"inThigh");
  //*/
  //      GET
  
  
  
  bRoot.x = xC;
  bRoot.y = baseY;
}

void draw(){
  //clear();
  lowY = 0;
  xMin = 1000;
  xMax = 0;
  background(200);
  text(jkl++,20,20);
  //*
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
  bRoot.place(false);
  yMomentum -= 0.4;
  xMomentum *= .9;
  if (lowY > baseY) {
    bRoot.y -= (lowY-baseY);
    yMomentum += ((lowY-baseY)/2);
    xMomentum += (avg(avg(xMin,xMax)-lowYX,avg(top.currY,lowYX)-lowYX)/200);
  }
  bRoot.x += xMomentum;
  bRoot.y -= yMomentum;
  noStroke();
  fill(0,20);
  ellipse(avg(xMin,xMax),baseY,max(0,(xMax-xMin)*(bRoot.y/height)),max(0,((xMax-xMin)/5)*(bRoot.y/height)));
  
  //*/
  
  stroke(skin);
  fill(skin);
  
  //  Draw Head and Neck
  tri(neckTop,neckBase,neckWid);
  tri(neckTop,chin,neckBase);
  fill(shadow);
  noStroke();
  tri(neckTop,chin,sPlexus);
  tri(neckTop,sPlexus,neckWid);
  fill(skin);
  stroke(skin);
  tri(top,headWid,jaw);
  tri(headWid,ear,jaw);
  tri(top,chin,jaw);
  
  //  Draw Torso
  tri(neckWid,shoulder,armpit);
  tri(armpit,neckWid,neckBase);
  tri(armpit,ribs,neckBase);
  tri(ribs,neckBase,navel);
  tri(ribs,waist,navel);
  tri(waist,hip,navel);
  tri(groin,hip,navel);
  tri(sPlexus,inCupLow,cupLow);
  tri(sPlexus,cupLow,ribs);
  
  //  Draw Arm
  tri(shoulder,deltoid,deltoidEnd);
  tri(shoulder,elbow,armpit);
  tri(elbow,inElbow,armpit);
  tri(elbow,inElbow,wrist);
  tri(armpit,cup,shoulder);
  
  //  Draw Leg
  tri(hip,thigh,knee);
  tri(hip,groin,knee);
  tri(groin,knee,inKnee);
  tri(knee,inKnee,calf);
  tri(knee,calf,outAnkle);
  tri(calf,ankle,outAnkle);
  tri(foot,outAnkle,heel);
  tri(heel,ankle,outAnkle);
  
  //  Draw Shadows
  fill(shadow);
  noStroke();
  // Groin
  shadow(groin,pubic,hip);
  //tri(groin,inThigh,inKnee);
  //tri(pubic,inThigh,groin);
  // Underarm
  //tri(inElbow,armpit,shoulder);
  shadow(shoulder,cup,armpit);
  shadow(armpit,ribs,cup);
  shadow(ribs,cup,cupLow);
  shadow(cup,cupLow,inCup);
  shadow(cupLow,inCup,inCupLow);
  shadow(inCup,inCupLow,sPlexus);
  // foot
  shadow(ankle,heel,foot);
  
  // eye
  ellipse(eye.currX,eye.currY,10,10);
  ellipse(eye.sibling.currX,eye.sibling.currY,10,10);
  
  if (saveImg == true){
    if (jkl > 1000 && jkl < 1200) saveFrame("imgs/img-###.jpg");
    if(jkl > 1200) exit();
  }
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

void shadow(Node a, Node b, Node c){
  fill(skin);
  stroke(skin);
  tri(a,b,c);
  
  fill(shadow);
  noStroke();
  tri(a,b,c);
}

void tri(Node a, Node b, Node c){
  triangle(a.currX,a.currY,b.currX,b.currY,c.currX,c.currY);
  if (a.sibling != null) a = a.sibling;
  if (b.sibling != null) b = b.sibling;
  if (c.sibling != null) c = c.sibling;
  triangle(a.currX,a.currY,b.currX,b.currY,c.currX,c.currY);
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
    for (int j = 0; j < nChildren.length; j++){
      nChildren[j].place();
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
  float x,y,distP,currX,currY,angle, currAngle;
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
    if (x > 0) {
      Bone par = parent;
      if (par.sibling != null) par = par.sibling;
      sibling = new Node (-x,y,par,name);
      print("A node sibling was created successfully");
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
  void place(){
    if (parent != null){
      currAngle = angle + (parent.currAngle - parent.angle);
      currX = parent.currX+(distP*cos(currAngle));
      currY = parent.currY+(distP*sin(currAngle));
    } else {
      //currAngle = angle;
      currX = x;
      currY = y;
    }
    if (currY > lowY) {lowY = currY;lowYX = currX;}
    if (currX > xMax) xMax = currX;
    if (currX < xMin) xMin = currX;
  }
}