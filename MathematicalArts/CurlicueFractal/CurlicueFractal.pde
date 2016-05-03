/*

CURLICUE FRACTAL

The curlicue fractal is a figure obtained by the following procedure. 
Let s be an irrational number. Begin with a line segment of unit length, 
which makes an angle phi_0=0 to the horizontal.

      theta(n+1) = (theta(n) + 2 * PI * s) * (mod 2 * PI)
      phi(n+1) = theta(n) + phi(n) * (mod * 2 * PI)

      CONSTANT                      TEMPERATURE
      
      golden ratio (phi)            46
      ln 2                          51
      e                             58
      √2                            58
      Euler-Mascheroni (gamma)      63
      PI                            90
      Feigenbaum constant (delta)   92

      The "temperature" of a curve (gamma) is defined as
      
      T = 1.0 / (ln((2 * l)/(2 * l - h))) 

REFERENCES:
http://mathworld.wolfram.com/CurlicueFractal.html
http://oolong.co.uk/curlicue.htm

@author  Vladimir V. KUCHINOV
@email   helloworld@vkuchinov.co.uk

*/

Curlicue fractal;

void setup(){
  
     size(750, 750, "processing.core.PGraphicsRetina2D");
     background(255);
     translate(width/5, height/3);
  
     fractal = new Curlicue(9999);
     fractal.draw();
     
}

//void draw(){
//  
//     background(255); 
//     translate(width/5, height/3);
//     
//     float s = map(mouseX, 0, width, 1.0, 5.0);
//     
//     fractal = new Curlicue(9999, s);
//     fractal.draw();
//     
//}
