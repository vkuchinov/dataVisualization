/*

SAUNDERS GRAPHIC

'The purpose of this paper is to describe a numerical technique that can be used to 
produce patternscalled Character Maps.' — R. P. Saunders, 1972


is a plot of the dth base-b digits of a function  
f(x,y) as a function of x and y.

    b: base*
    d: integers 
    
    The word "base" in mathematics is used to refer to a particular mathematical 
    object that is used as a building block. The most common uses are the related 
    concepts of the number system whose digits are used to represent numbers and 
    the number system in which logarithms are defined. It can also be used to refer 
    to the bottom edge or surface of a geometric figure.
    
    BASES:
    
    2  binary        3  ternary        4  quaternary        5  quinary        6  senary
    7  septenary     8  octal          9  nonary            10  decimal       11  undenary
    12  duodecimal   16  hexadecimal   20  vigesimal        60  sexagesimal
    
SAMPLE

    b = 2;          
    d = 1 to 2; 
    plot points = 45;
    
    function: the trigonometric or inverse trigonometric function to be used
    complex component: the part of the complex number to use for the digit extraction
    base: the base in which to express the numerical value
    digit: the digit to visualize
    domain size: extension of the domain in which to plot the function
    plot points: discretization of the real and imaginary parts
    
    
    f(x, y) > Re[cos]
    
    This demonstrates Saunders plots of trigonometric and inverse trigonometric functions. Given 
    a function f at a complex number z, the real part, imaginary part, absolute value, or argument of 
    f(z) can be expressed in base b as:

    seereference image @ /References

    A Saunders graphic shows the chosen digit Subsuperscript[a, j, (b)] encoded in the colors of squares 
    centered at the corresponding complex z-values.


    The plots above show Saunders graphics for the functions 
    f(x,y) = R[sin(x+iy)],  I[sin(x+iy)], R[cos(x+iy)], and  
    I[cos(x+iy)] in base b = 2 for digits d = 1 to 3.
    
    RealDigits[#2[#1[x + I y]], 2, 2, -n][[1, 1]], {x, -Pi, Pi}, {y, -Pi, Pi},
    
    RealDigits[123.5555555]
              {{1, 2, 3, 5, 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0}, 3}
            
    RealDigits[0.000012355555]
              {{1, 2, 3, 5, 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0}, -4}
              
    RealDigits[PI, 10, 25] 10 is base, 25: # of numbers
              {{3, 1, 4, 1, 5, 9, 2, 6, 5, 3, ..., 4, 3}, 1} 
              
    RealDigits[x, b, len, n] gives len digits starting with the coefficient of bⁿ
    
    adds n of 0 before
    
    RealDigits[PI, 10, 25, 2] 
              {{0, 0, 3, 1, 4, 1, 5, 9, 2, 6, 5, 3, ..., 2, 6}, 1} 
              
    RealDigits[PI, 10, 2] // {{3, 1}, 1}
    
    RealDigits[PI, 2, 2]  // {{1, 1}, 2}
    
                             {{....}, decimal point}
                             
     
              

Saunders couldbe used to create a vareity of vector fields 
for further experiments.

REFERENCES: 
https://en.wikipedia.org/wiki/Combination

http://comjnl.oxfordjournals.org/content/15/2/160.full.pdf
http://mathworld.wolfram.com/SaundersGraphic.html
http://functions.wolfram.com/ElementaryFunctions/Sin/visualizations/18/
http://functions.wolfram.com/ElementaryFunctions/ArcCos/visualizations/18/
http://search.wolfram.com/ancient/?query=Saunders+graphics&collection=functions&lang=en

http://demonstrations.wolfram.com/SaundersDigitGraphics/

@author  Vladimir V. KUCHINOV
@email   helloworld@vkuchinov.co.uk

*/

String dataA[], dataB[], dataC[], lineA[], lineB[], lineC[];
int frame = 0;

void setup(){
  
   size(700, 700); 
   frameRate(6);
   
   dataA = loadStrings("data1.txt");
   dataB = loadStrings("data2.txt");
   dataC = loadStrings("data3.txt");
   
   background(0);
   noStroke();
     
}

void draw(){
  
  background(0);
  
  for(int y = 0; y < dataA.length; y++){
     
     lineA = split(dataA[y], ",");
     lineB = split(dataB[y], ",");
     lineC = split(dataC[y], ",");
     
     for(int x = 0; x < dataA.length; x++){
       
       float result = 0.0;
       
       float A = Float.parseFloat(lineA[x]);
       float B = Float.parseFloat(lineB[x]);
       float C = Float.parseFloat(lineC[x]);
       
       int innerFrame = frame % 40;
       
       if(frame < 40) result = lerp(A, B, 1.0 / 40.0 * innerFrame);
       if(frame > 39 && frame < 80) result = lerp(B, C, 1.0 / 40.0 * innerFrame);
       if(frame > 79) result = lerp(C, A, 1.0 / 40.0 * innerFrame);
       
       int state = RealDigits(result, 2, 2, -1, 0);
       
       if(state == 0) { fill(0); } else { fill(255); }
       rect(50 + x * 2, 50 + y * 2, 2, 2);
       
     }    
   }
   
   save("frame" + frame + ".jpg");
   if(frame > 119) { noLoop(); } else { frame++; }
    
}

