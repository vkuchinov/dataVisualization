/*

 COMPLEX PANE 2D [or Complex Plot]*
 
 In complex plot X axis equals to Re (real part) and Y axis to Im (imaginary part).
 The result of function is represented by Z axis.
 
 
 * with data output
 
 @author   Vladimir V. KUCHINOV
 @email    helloworld@vkuchinov.co.uk
 
*/

import processing.opengl.*;
import igeo.*;


ComplexPlot3D plot;

void setup(){
  
  size(640, 480, IG.GL );
  IG.background(0);
  IG.perspective();
  
  plot = new ComplexPlot3D(600, 64, new float[]{-2 * PI, 2 * PI}, new float[]{-2 * PI, 2 * PI});
  plot.offset(-150, -150);
  plot.display();
  
  //plot.exportData("output.txt");
 
}
