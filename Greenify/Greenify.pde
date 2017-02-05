PImage picture;

void setup() {
  picture = loadImage("https://f0d9fabc.ngrok.io/images/test_img.png");
  
  tint(0,229,0);
}

void settings() {
 size(Integer.parseInt(args[0]), Integer.parseInt(args[1])); 
}

void draw() {
  background(0);
  image(picture, 0, 0);
  
  saveFrame("../../public/images/test_img.png");
  
  exit();
}