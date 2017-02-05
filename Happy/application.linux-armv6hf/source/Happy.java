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

public class Happy extends PApplet {

PImage picture;

  String img_url;
  
  int top;
  int left;
  int width;
  int height;
   
  int midpointx;
  int midpointy;

public void setup() {
  
  
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
 
public void draw() {
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
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Happy" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
