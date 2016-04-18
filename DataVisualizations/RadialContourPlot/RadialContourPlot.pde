/*

RADIAL [POLAR] CONTOUR PLOT

      Cartesian to Polar
      
      r = √ ( x2 + y2 )
      θ = tan⁻¹( y / x )
      

REFERENCES:
http://www.mathworks.com/matlabcentral/answers/95796-how-do-i-create-a-contour-plot-in-polar-coordinates
http://www.mathworks.com/matlabcentral/answers/95796-how-do-i-create-a-contour-plot-in-polar-coordinates
https://reference.wolfram.com/language/ref/EllipticTheta.html
http://docs.sympy.org/0.7.6/modules/mpmath/functions/elliptic.html#jacobi-theta-functions


@author Vladimir V. KUCHINOV
@email  helloworld@vkuchinov.co.uk

*/

Radial plot;

void setup(){
 
    size(600, 600);
    background(0); 
    
     plot = new Radial(500, 192, new float[]{-2 * PI, 2 * PI}, new float[]{-2 * PI, 2 * PI});
     plot.offset(50, 50);
     plot.display();
  
}
