/*

KIVIAT DIAGRAM or RADAR CHART
also known as web chart, spider chart, 
polar chart or corona diagram


REFERENCES:
https://en.wikipedia.org/wiki/Radar_chart


@author  Vladimir V. KUCHINOV
@email   helloworld@vkuchinov.co.uk

*/


Kiviat diagram;
float[][] data = {{23.04, 60.09, 12.22, 87.01, 49.00},
                  {30.04, 120.09, 55.22, 10.01, 9.00},
                  {33.04, 10.09, 112.22, 87.01, 15.00},
                  {78.04, 65.09, 32.22, 65.01, 100.00},
                 };

void setup(){
  
     size(600, 600, "processing.core.PGraphicsRetina2D"); 
     background(240);
  
     diagram = new Kiviat(5, 250.0, data);
     diagram.draw();
     
}

