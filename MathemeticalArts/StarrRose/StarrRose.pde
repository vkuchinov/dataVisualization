/*
STARR ROSE

Starr roses are attractive geometric figures.


REFERENCES:
http://mathworld.wolfram.com/StarrRose.html

@author   Vladimir V. KUCHINOV
@email    helloworld@vkuchinov.co.uk

*/

Starr rose;
float noiseScale = 0.0001;

void setup(){ size(600, 600); }

void draw(){
  
     background(49);
     
     float a = 6.0; //2.0 + 2.0 * noise(millis() * noiseScale, noiseScale);
     float b = 18.0; //map(abs(width/2 - mouseX), 0, width/2, 8, 32);
     float c = 18.0; //map(abs(height/2 - mouseY), 0, height/2, 8, 32);
     
     rose = new Starr(a, b, c);
     rose.draw();

}
