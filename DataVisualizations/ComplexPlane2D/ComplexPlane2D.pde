/*

 COMPLEX PANE 2D [or Complex Plot]*
 
 In complex plot X axis equals to Re (real part) and Y axis to Im (imaginary part).
 The result of function is represented by Z axis.
 
 
 * with data output
 
 @author   Vladimir V. KUCHINOV
 @email    helloworld@vkuchinov.co.uk
 
*/

ComplexPlot plot;

void setup(){
  
  size(700, 700, "processing.core.PGraphicsRetina2D");
  background(0);
  noStroke();
  
  plot = new ComplexPlot(600, 96, new float[]{-2 * PI, 2 * PI}, new float[]{-2 * PI, 2 * PI});
  plot.offset(50, 50);
  plot.display();
  //plot.displayAsVectorField();
  
  //plot.exportData("output.txt");
 
}
