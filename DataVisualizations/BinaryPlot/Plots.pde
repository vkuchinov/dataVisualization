class BinaryPlot {

  float width_, height_;

  BinaryPlot(String[] data_, int dim_, float size_) {

    width_ = data_.length * size_;
    height_ = dim_ * size_;

    for (int s = 0; s < data_.length; s++) {

      String currentElement = data_[s];

      for (int c = 0; c  < currentElement.length (); c++) {

        char current = currentElement.charAt(c);
        noStroke();
        fill(0);
        if (current == '1') { 
          rect(-width_/2 + size_*s, -height_/8 + size_*c, size_, size_);
        }
      }
    }
  }
  
  //with margins
  BinaryPlot(String[] data_, int dim_, float size_, int margin_) {

    width_ = data_.length * size_;
    height_ = dim_ * size_;

    for (int s = 0; s < data_.length; s++) {

      String currentElement = data_[s];

      for (int c = 0; c  < currentElement.length (); c++) {

        char current = currentElement.charAt(c);
        noStroke();
        fill(0);
        if (current == '1') { 
          rect(margin_ - width_/2 + size_*s, -height_/8 + size_*c, size_, size_);
        }
      }
    }
  }
}

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
