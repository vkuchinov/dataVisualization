class Equipotential{


   PImage scene;
   
   double RADIUS = 500E-12;                // real size (m)
   float ratio = 5.0;                      // waves density
   double eps = RADIUS / width;            // real size of 1 pixel
   double e = 1.60217733E-19;              // elementary charge (C)
   
   ChargeList charges = new ChargeList();  // the N random charges

   Equipotential(int numOfCharges_){
     
        scene = createImage(1600, 1600, RGB);
        
        for (int i = 0; i < numOfCharges_; i++) {
          
            double x = Math.random() * RADIUS;
            double y = Math.random() * RADIUS;
            double k = e;
            
            double random = Math.random();
            if (random < 0.4) { k = -e; } else if(random > 0.6) { k = e; } 
            charges.add(new Charge(x, y, k));
            
        }

   }
   
   void render(){
     
        //this.scene.loadPixels();
        println(0 * RADIUS / width);
        
        //4.999999858590343E-10

        for (int ix = 0; ix < width; ix++) {
            for (int iy = 0; iy < height; iy++) {
              
                double x = ix * RADIUS / width;
                double y = iy * RADIUS / height;

                
          
                double V = 0.0;
                
                for (int i = 0; i < charges.size(); i++) {
                    
                      V += charges.get(i).potentialTo(x, y);

                }

                double Ex = 0.0, Ey = 0.0;
                
                for (int i = 0; i < charges.size(); i++) {
                  
                    Ex += charges.get(i).fieldX(x, y);
                    Ey += charges.get(i).fieldY(x, y);
                    
                }
                
                double E = Math.sqrt(Ex*Ex + Ey*Ey);

                // draw if potential is < 1/2 pixel from a multiple of 5V (since E = grad V)
                // ((Math.abs(V) % 5) < 1.0 * E * eps)
                if ((V - Math.floor(V/ratio) * ratio) <  1.0 * E * eps) {
                  
                    this.scene.set(ix, height - iy, color(255, 255, 255));
                }
                else {
                  
                  this.scene.set(ix, height - iy, color(#2C3E50));
                  
                }
            }
        }

        this.scene.updatePixels();
        image(this.scene, 0, 0);
        
        }
        
        void updateRatio(float ratio_){
          
          ratio = ratio_;
          
        }
        
   }
