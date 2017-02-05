PImage picture;

  String img_url;
  
  int top;
  int left;
  int width;
  int height;
   
  int midpointx;
  int midpointy;

void setup() {
  
  
  img_url = args[0]; 
  top = Integer.parseInt(args[1]);
  left = Integer.parseInt(args[2]);
  width = Integer.parseInt(args[3]);
  height = Integer.parseInt(args[4]);

  
  picture = loadImage(img_url);
}

public void settings() {
   size(Integer.parseInt(args[5]),Integer.parseInt(args[6])); 
}
 
void draw() {
  background(0);
  image(picture,0,0);
  
  midpointx = left+(width/2);
  midpointy = top +(height/2);
  noFill();
  stroke(255,255,0);
  strokeWeight(4);
  ellipse(midpointx, midpointy, width, height);
  
  saveFrame("../../public/images/test_img.png");
   
  exit();
}