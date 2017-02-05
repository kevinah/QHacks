import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class QHacks extends PApplet {

PImage picture;
PImage face1;
PImage face2;
PImage mask1;
PImage mask2;
PImage stache;

  String img_url;
  
  int top1;
  int left1;
  int width1;
  int height1;

  int midpointx1;
  int midpointy1;
  float pupilLeftx1;
  float pupilLefty1;
  float pupilRightx1;
  float pupilRighty1;
  float noseTipx1;
  float noseTipy1;
  float mouthLeftx1;
  float mouthLefty1;
  float mouthRightx1;
  float mouthRighty1;
  
  int top2;
  int left2;
  int width2;
  int height2;

  float pupilLeftx2;
  float pupilLefty2;
  float pupilRightx2;
  float pupilRighty2;
  float noseTipx2;
  float noseTipy2;
  float mouthLeftx2;
  float mouthLefty2;
  float mouthRightx2;
  float mouthRighty2;
  
  String mode;
  
  float horiDistLF;
  float vertDistLF;
  float horiDistRF;
  float vertDistRF;
  
  float leftRotate;
  float rightRotate;
  
  int LL = 0;
  int RR = 0;
  int LR = 0;
  int RL = 0;


public void setup() {
  
  
  img_url = args[0]; 
  top1 = Integer.parseInt(args[1]);
  left1 = Integer.parseInt(args[2]);
  width1 = Integer.parseInt(args[3]);
  height1 = Integer.parseInt(args[4]);

  pupilLeftx1 = Float.parseFloat(args[5]);
  pupilLefty1 = Float.parseFloat(args[6]);
  pupilRightx1 = Float.parseFloat(args[7]);
  pupilRighty1 = Float.parseFloat(args[8]);
  noseTipx1 = Float.parseFloat(args[9]);
  noseTipy1 = Float.parseFloat(args[10]);
  mouthLeftx1 = Float.parseFloat(args[11]);
  mouthLefty1 = Float.parseFloat(args[12]);
  mouthRightx1 = Float.parseFloat(args[13]);
  mouthRighty1 = Float.parseFloat(args[14]);
  /*
  top2 = Integer.parseInt(args[5]);
  left2 = Integer.parseInt(args[6]);
  width2 = Integer.parseInt(args[7]);
  height2 = Integer.parseInt(args[8]);
  */
  
  top2 = Integer.parseInt(args[15]);
  left2 = Integer.parseInt(args[16]);
  width2 = Integer.parseInt(args[17]);
  height2 = Integer.parseInt(args[18]);
   

  pupilLeftx2 = Float.parseFloat(args[19]);
  pupilLefty2 = Float.parseFloat(args[20]);
  pupilRightx2 = Float.parseFloat(args[21]);
  pupilRighty2 = Float.parseFloat(args[22]);
  noseTipx2 = Float.parseFloat(args[23]);
  noseTipy2 = Float.parseFloat(args[24]);
  mouthLeftx2 = Float.parseFloat(args[25]);
  mouthLefty2 = Float.parseFloat(args[26]);
  mouthRightx2 = Float.parseFloat(args[27]);
  mouthRighty2 = Float.parseFloat(args[28]);
  
  picture = loadImage(img_url);
  mask1 = loadImage("PImageMask.png");
  mask2 = loadImage("PImageMask2.png");
  stache = loadImage("https://d30y9cdsu7xlg0.cloudfront.net/png/1642-200.png", "png");
}

public void settings() {
   size(Integer.parseInt(args[29]),Integer.parseInt(args[30])); 
   mode = args[31];
}
 
public void draw() {
  background(0);
  image(picture,0,0);
  
  if (mode.equals("faceswap")) {
    face1 = get(left1,top1,width1,height1);
    face2 = get(left2,top2,width2,height2);
    
    mask1.resize(face1.width, face1.height);
    face1.mask(mask1);
    face1.resize(width2, height2);
    //image(face1, left2, top2);
  
    mask2.resize(face2.width, face2.height);
    face2.mask(mask2);
    face2.resize(width1, height1);
    //image(face2, left1, top1);
    
    rotateFaces();
    
    saveFrame("../public/images/test_img.png");
  }
  
  if (mode.equals("moustache")) {
    image(stache,mouthLeftx1,(noseTipy1),(mouthRightx1-mouthLeftx1),(mouthRighty1-noseTipy1));
    if (top2 != 0) { 
      image(stache,mouthLeftx2,(noseTipy2),(mouthRightx2-mouthLeftx2),(mouthRighty2-noseTipy2));
   }
    
    saveFrame("../public/images/test_img.png");
  }
  exit();
}

public void rotateFaces() {
  // FACE 1 LEFT
  //means it is left pupil in image one is higher than right (rotate right)
  if (pupilLefty1 > pupilRighty1 && pupilLefty2 > pupilRighty2) { //Both slanted left
      System.out.println("FACE 1 SLANTED LEFT");
      vertDistLF = pupilLefty1 - pupilRighty1;
      horiDistLF = pupilRightx1 - pupilLeftx1;
      System.out.println("val1:" + vertDistLF);
      System.out.println("val2:" + horiDistLF);
      System.out.println("FACE 2 SLANTED LEFT");
      vertDistRF = pupilLefty2 - pupilRighty2;
      horiDistRF = pupilRightx2 - pupilLeftx2;
      System.out.println("val1:" + vertDistRF);
      System.out.println("val2:" + horiDistRF);
      leftRotate = atan(vertDistLF/horiDistLF);
      rightRotate = atan(vertDistRF/horiDistRF);
      LL = 1;
      RR = 0;
      LR = 0;
      RL = 0;
  } else if (pupilLefty1 < pupilRighty1 && pupilLefty2 < pupilRighty2) { //both slanted right
      System.out.println("FACE 1 SLANTED RIGHT");
      vertDistLF = pupilRighty1 - pupilLefty1;
      horiDistLF = pupilRightx1 - pupilLeftx1;
      System.out.println("FACE 2 SLANTED RIGHT");
      vertDistRF = pupilRighty2 - pupilLefty2;
      horiDistRF = pupilRightx2 - pupilLeftx2;
      leftRotate = atan(vertDistRF/horiDistRF);
      rightRotate = atan(vertDistLF/horiDistLF);
      LL = 0;
      RR = 1;
      LR = 0;
      RL = 0;
  } else if (pupilLefty1 > pupilRighty1 && pupilLefty2 < pupilRighty2) { //1 slanted left 2 slanted right
      System.out.println("FACE 1 SLANTED LEFT");
      vertDistLF = pupilLefty1 - pupilRighty1;
      horiDistLF = pupilRightx1 - pupilLeftx1;
      System.out.println("FACE 2 SLANTED RIGHT");
      vertDistRF = pupilRighty2 - pupilLefty2;
      horiDistRF = pupilRightx2 - pupilLeftx2;
      leftRotate = atan(vertDistLF/horiDistLF);
      rightRotate = atan(vertDistRF/horiDistRF);
      LL = 0;
      RR = 0;
      LR = 1;
      RL = 0;
  } else if (pupilLefty1 < pupilRighty1 && pupilLefty2 > pupilRighty2) { //1 slanted right 2 slanted left
      System.out.println("FACE 1 SLANTED RIGHT");
      vertDistLF = pupilRighty1 - pupilLefty1;
      horiDistLF = pupilRightx1 - pupilLeftx1;
      System.out.println("FACE 2 SLANTED LEFT");
      vertDistRF = pupilLefty2 - pupilRighty2;
      horiDistRF = pupilRightx2 - pupilLeftx2;
      leftRotate = atan(vertDistLF/horiDistLF);
      rightRotate = atan(vertDistRF/horiDistRF);
      LL = 0;
      RR = 0;
      LR = 0;
      RL = 1;
  } else {
      leftRotate = 0;
      rightRotate = 0;
  }
  
  System.out.println("Left Rotation: "+ leftRotate);
  System.out.println("Right Rotation: "+ rightRotate);
  
  //FACE 1 is NOAM FACE 2 is KEVIN
  //FACE 1
  pushMatrix();
  translate(left1 + face1.width/2, top1 + face1.height/2);
  //rotate(rightRotate-leftRotate); //(leftRotate)SR SL, (rightRotate-leftRotate) SL SL, (-(rightRotate + leftRotate)) SL SR
  if ((LL == 0) && (RR == 0) && (RL == 1) && (LR == 0)) {
    rotate(leftRotate);
  } else if ((LL == 1) && (RR == 0) && (RL == 0) && (LR == 0)) {
    rotate(rightRotate-leftRotate);
  } else if ((LL == 0) && (RR == 1) && (RL == 0) && (LR == 0)) {
    rotate(rightRotate-leftRotate);
  } else if ((LL == 0) && (RR == 0) && (RL == 0) && (LR == 1)) {
    rotate(rightRotate-leftRotate);
  }
  translate(-face1.width/2, -face1.height/2);
   //Draw Face in top left
  image(face2, 0, 0);
  popMatrix(); 
  
  //FACE 2
  pushMatrix();
  translate(left2 + face2.width/2, top2 + face2.height/2);
  //  rotate(leftRotate-rightRotate); //(rightRotate - leftRotate)SR SL, (rightRotate) SL SL,(rightRotate + leftRotate) SL SR
  if ((LL == 0) && (RR == 0) && (RL == 1) && (LR == 0)) {
    rotate(rightRotate - leftRotate);
  } else if ((LL == 1) && (RR == 0) && (RL == 0) && (LR == 0)) {
    rotate(rightRotate);
  } else if ((LL == 0) && (RR == 1) && (RL == 0) && (LR == 0)) {
    rotate(leftRotate-rightRotate);
  } else if ((LL == 0) && (RR == 0) && (RL == 0) && (LR == 1)) {
    rotate(leftRotate-rightRotate);
  }
  translate(-face2.width/2, -face2.height/2);
   //Draw Face in top left
  image(face1, 0, 0);
  popMatrix();
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "QHacks" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
