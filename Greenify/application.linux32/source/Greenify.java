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

public class Greenify extends PApplet {

PImage picture;

public void setup() {
  picture = loadImage("https://f0d9fabc.ngrok.io/images/test_img.png");
  
  tint(0,229,0);
}

public void settings() {
 size(Integer.parseInt(args[0]), Integer.parseInt(args[1])); 
}

public void draw() {
  background(0);
  image(picture, 0, 0);
  
  saveFrame("../../public/images/test_img.png");
  
  exit();
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Greenify" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
