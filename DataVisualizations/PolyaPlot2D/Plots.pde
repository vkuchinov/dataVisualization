//http://mathworld.wolfram.com/PolyaPlot.html
//http://www.wolframalpha.com/input/?i=sin(z)
class PolyaPlot{
  
   PolyaPlot(){
    
     //function sin(z);
     //R[f(z)] - I[f(z)]
     
     for(float y = -3.0; y < 3.0; y += 0.25){
       for(float x = -6.0; x < 6.0; x += 0.5){
         
         PVector xx = new PVector(sin(x), 0);
         PVector yy = new PVector(0, sin(y));
         xx.add(yy);
         
         pushMatrix();
         translate(x*60.0, y*30.0);
         rotate(xx.heading());
         strokeWeight(2);
         point(0, 0);
         strokeWeight(0.8);
         line(0, 0, 4, 0);
         popMatrix();
         
       }
     }
    
   } 

}
