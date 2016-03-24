/*

POINCARÉ MAP/SECTION/SURFACE/SPACE

A surface (or "space") of section, also called a Poincaré section 
(Rasband 1990, pp. 7 and 93-94), is a way of presenting a trajectory 
in n-dimensional phase space in an (n-1)-dimensional space. 
By picking one phase element constant and plotting the values of 
the other elements each time the selected element has the desired value, 
an intersection surface is obtained.

Henri Poincaré ( 29 April 1854 – 17 July 1912) : a French mathematician, 
theoretical physicist, engineer, and a philosopher of science.

PHASE SPACE

For a system of n first-order ordinary differential equations (or more generally, 
Pfaffian forms), the 2n-dimensional space consisting of the possible values of 
(x_1,x^._1,x_2,x^._2,...,x_n,x^._n) is known as its phase space.

EXAMPLE:
Hénon-Heiles equation: E = 1/8 plotting y(t) vs. y(t) at values where x(t) = 0

Hénon-Heiles potentials:
V(x, y) = 1 / 2 * (x² + y²) + λ * (x² * y - y³ / 3)
V(x, y), where V means VAR or VARIANCE [of two variables]

REFERENCES:
http://mathworld.wolfram.com/PhaseSpace.html
http://mathworld.wolfram.com/SurfaceofSection.html
https://en.wikipedia.org/wiki/Poincar%C3%A9_map

http://wwwstaff.ari.uni-heidelberg.de/mitarbeiter/ernst/movies.html
http://a-ma.us/wp/2011/05/generating-poincare-sections-and-return-maps/

@author   Vladimir V. KUCHINOV
@email    helloworld@vkuchinov.co.uk

*/

Poincare surface;

void setup(){
  
     size(750, 750, "processing.core.PGraphicsRetina2D");
     background(255);
     
     surface = new Poincare(width/2, height/2, 300.0);
     
     surface.drawAxis();
     
      
}

