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
  
  float horiDistL1;
  float vertDistL1;
  float horiDistR1;
  float vertDistR1;
  
  float horiDistL2;
  float vertDistL2;
  float horiDistR2;
  float vertDistR2;
  
  float leftRotate;
  float rightRotate;


void setup() {
  
  
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
 
void draw() {
  background(0);
  //imageMode(CENTER);
  image(picture,0,0);
  
  if (mode.equals("faceswap")) {
    face1 = get(left1,top1,width1,height1);
    face2 = get(left2,top2,width2,height2);
    
    
     
    mask1.resize(face1.width, face1.height);
    face1.mask(mask1);
  
    face1.resize(width2, height2);
    
    image(face1, left2, top2);
  
    mask2.resize(face2.width, face2.height);
    face2.mask(mask2);
  
    face2.resize(width1, height1);
    image(face2, left1, top1);
    
    
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