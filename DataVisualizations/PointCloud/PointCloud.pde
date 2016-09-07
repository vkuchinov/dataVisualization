/*

POINT CLOUD
[a very basic example with 3D torus]

A point cloud is a set of data points in some coordinate system.

In a three-dimensional coordinate system, these points are usually defined by X, Y, and Z 
coordinates, and often are intended to represent the external surface of an object.

Point clouds may be created by 3D scanners. These devices measure a large number of points 
on an object's surface, and often output a point cloud as a data file. 
The point cloud represents the set of points that the device has measured.

x(u,v) = (c+acos(v))cos(u)
y(u,v) = (c+acos(v))sin(u)
z(u,v) = asin(v)

REFERENCES:
https://en.wikipedia.org/wiki/Point_cloud


@author  Vladimir V. KUCHINOV
@email   helloworld@vkuchinov.co.uk

*/

final static int NUM_OF_POINTS = 5120;

float torusRadius = 250.0,  torusWeight = 100.0;
ArrayList<PVector> points = new ArrayList<PVector>();

void setup(){
  
     size(500, 500, P3D);
     feedTorus();

}

void draw(){
  
     background(0);
   
     translate(width/2, height/2);
     rotateY((float)mouseX/width*TWO_PI);
     rotateX((float)mouseY/height*TWO_PI);
    
     colorMode(HSB);
     strokeWeight(3);
     
     for(PVector p: points) { stroke(map(p.y, -torusWeight, torusWeight, 0, 255), 255, 255); point(p.x, p.y, p.z); }

     
}

void feedTorus(){

     for(int p = 0; p < NUM_OF_POINTS; p++){
       
          float theta = random(0.0, TWO_PI);
          float cx = sin(theta);
          float cy = 0;
          float cz = cos(theta);
          
          float phi = random(0.0, TWO_PI);
          int r = 150 + int(100.0 * cos(phi));
          int b = 150 + int(100.0 * sin(phi));
        
          float x = torusRadius * cx + torusWeight * sin(phi) * cx;
          float y = torusRadius * cy + torusWeight * cos(phi);
          float z = torusRadius * cz + torusWeight * sin(phi) * cz;
          
          points.add(new PVector(x, y, z));

     }
      
}
