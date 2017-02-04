PImage picture;
PImage face1;
PImage face2;
//PImage stache;

  int img_wdt;
  int img_hgt;
  String img_url; 
  int top;
  int left;
  int width;
  int height;

  int midpointx;
  int midpointy;
  //float pupilLeftx = Float.parseFloat(args[5]);
  //float pupilLefty = Float.parseFloat(args[6]);
  //float pupilRightx = Float.parseFloat(args[7]);
  //float pupilRighty = Float.parseFloat(args[8]);
  //float noseTipx = Float.parseFloat(args[9]);
  //float noseTipy = Float.parseFloat(args[10]);
  //float mouthLeftx = Float.parseFloat(args[11]);
  //float mouthLefty = Float.parseFloat(args[12]);
  //float mouthRightx = Float.parseFloat(args[13]);
  //float mouthRighty = Float.parseFloat(args[14]);
  
  int top2;
  int left2;
  int width2;
  int height2;
  /*
  int top2 = Integer.parseInt(args[15]);
  int left2 = Integer.parseInt(args[16]);
  int width2 = Integer.parseInt(args[17]);
  int height2 = Integer.parseInt(args[18]);
   */

  int midpointx2;
  int midpointy2;

  //float pupilLeftx2 = Float.parseFloat(args[19]);
  //float pupilLefty2 = Float.parseFloat(args[20]);
  //float pupilRightx2 = Float.parseFloat(args[21]);
  //float pupilRighty2 = Float.parseFloat(args[22]);
  //float noseTipx2 = Float.parseFloat(args[23]);
  //float noseTipy2 = Float.parseFloat(args[24]);
  //float mouthLeftx2 = Float.parseFloat(args[25]);
  //float mouthLefty2 = Float.parseFloat(args[26]);
  //float mouthRightx2 = Float.parseFloat(args[27]);
  //float mouthRighty2 = Float.parseFloat(args[28]);
  //size(Integer.parseInt(args[9]),Integer.parseInt(args[10]));


void setup() {
  img_url = args[0]; 
  top = Integer.parseInt(args[1]);
  left = Integer.parseInt(args[2]);
  width = Integer.parseInt(args[3]);
  height = Integer.parseInt(args[4]);

  //float pupilLeftx = Float.parseFloat(args[5]);
  //float pupilLefty = Float.parseFloat(args[6]);
  //float pupilRightx = Float.parseFloat(args[7]);
  //float pupilRighty = Float.parseFloat(args[8]);
  //float noseTipx = Float.parseFloat(args[9]);
  //float noseTipy = Float.parseFloat(args[10]);
  //float mouthLeftx = Float.parseFloat(args[11]);
  //float mouthLefty = Float.parseFloat(args[12]);
  //float mouthRightx = Float.parseFloat(args[13]);
  //float mouthRighty = Float.parseFloat(args[14]);
  
  top2 = Integer.parseInt(args[5]);
  left2 = Integer.parseInt(args[6]);
  width2 = Integer.parseInt(args[7]);
  height2 = Integer.parseInt(args[8]);
  /*
  int top2 = Integer.parseInt(args[15]);
  int left2 = Integer.parseInt(args[16]);
  int width2 = Integer.parseInt(args[17]);
  int height2 = Integer.parseInt(args[18]);
   */

  //float pupilLeftx2 = Float.parseFloat(args[19]);
  //float pupilLefty2 = Float.parseFloat(args[20]);
  //float pupilRightx2 = Float.parseFloat(args[21]);
  //float pupilRighty2 = Float.parseFloat(args[22]);
  //float noseTipx2 = Float.parseFloat(args[23]);
  //float noseTipy2 = Float.parseFloat(args[24]);
  //float mouthLeftx2 = Float.parseFloat(args[25]);
  //float mouthLefty2 = Float.parseFloat(args[26]);
  //float mouthRightx2 = Float.parseFloat(args[27]);
  //float mouthRighty2 = Float.parseFloat(args[28]);
  //img_wdt=Integer.parseInt(args[9]);
  //img_hgt=Integer.parseInt(args[10]);
  //size(img_wdt, img_hgt);
  size(640,480);
  picture = loadImage(img_url);
  
  //String url = "https://d30y9cdsu7xlg0.cloudfront.net/png/1642-200.png";
  //stache = loadImage(url, "png");
}
 
void draw() {
  background(0);
  image(picture,0,0);
  //image(stache,mouthLeftx,(noseTipy),(mouthRightx-mouthLeftx),(mouthRighty-noseTipy));
 
  //fill(0,255,0);
  //pupilLeft
  //ellipse(pupilLeftx,pupilLefty,10,10);
  //pupilRight
  //ellipse(pupilRightx,pupilRighty,10,10);
  //noseTip
  //ellipse(noseTipx,noseTipy,10,10);
  //mouthLeft
  //ellipse(mouthLeftx,mouthLefty,10,10);
  //mouthRight
  //ellipse(mouthRightx,mouthRighty,10,10);
  
  //faceciccle
  midpointx = left+(width/2);
  midpointy = top+(height/2);
  noFill();
  ellipse(midpointx,midpointy,width,height);
 
  //fill(0,255,0);
  //pupilLeft2
  //ellipse(pupilLeftx2,pupilLefty2,10,10);
  //pupilRight2
  //ellipse(pupilRightx2,pupilRighty2,10,10);
  //noseTip2
  //ellipse(noseTipx2,noseTipy2,10,10);
  //mouthLeft2
  //ellipse(mouthLeftx2,mouthLefty2,10,10);
  //mouthRight2
  //ellipse(mouthRightx2,mouthRighty2,10,10);
 
  //faceciccle
  midpointx2 = left2+(width2/2);
  midpointy2 = top2+(height2/2);
  noFill();
  ellipse(midpointx2,midpointy2,width2,height2);
 
  face1 = get(left,top,width,height);
  face2 = get(left2,top2,width2,height2);
 
  image(face1, left2, top2);
  //blend(face1, left2, top2, width2, height2, left, top, height, width, DARKEST);
  image(face2, left, top);
  
  saveFrame("../public/images/test_img.png");
  
  exit();
}