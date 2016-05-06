class Moire {

  PGraphics back, fore;
  PGraphics mixed;

  float x0, y0, x1, y1;
  float alpha = 0.0;
  float scale = 1.0;

  Moire(float x0_, float y0_, float x1_, float y1_) {
    x0 = x0_; 
    y0 = y0_; 
    x1 = x1_; 
    y1 = y1_;
    
    back = createGraphics((int)(x1 - x0), (int)(y1 - y0));
    mixed = createGraphics(width, height);
    
  }

  void generateUniformField() {

    back.beginDraw(); 
    back.noStroke(); 
    back.fill(0);

    for (int n = 0; n < 1024; n++) {

      for (int r = 48; r > 4; r--) {

        back.fill(255, map(r, 48, 4, 0.25, 32));
        int x = (int)random(0, x1 - x0);
        int y = (int)random(0, y1 - y0);
        back.ellipse(x, y, r, r);
      }
    }

    back.endDraw(); 
    fore = back;
  }

  void generateStructure() {

    back.beginDraw(); 
    back.noStroke(); 
    back.fill(0);

    for (int y = (int)y0; y < y1; y += 6) {
      for (int x = (int)x0; x < x1; x += 6) {

        back.ellipse(x, y, 3, 3);
      }
    }

    back.endDraw(); 
    fore = back;
  }

  void draw() {

    mixed.clear();
    
    int mX = (int)map(mouseX, 0, width, -50, 50);
    int mY = (int)map(mouseY, 0, width, -50, 50);

    mixed.image(back, x0, y0); 

    mixed.pushMatrix();
    mixed.rotate(alpha);
    mixed.scale(scale);
    mixed.image(fore, x0 + mX, y0 + mY);
    mixed.popMatrix();
    
    mixed.filter(BLUR, 2);
    mixed.filter(THRESHOLD);
    
    image(mixed, 0, 0);
    
  }

  void keyPressed() {

    if (keyCode == LEFT) alpha -= 0.001;
    if (keyCode == RIGHT) alpha += 0.001;
    if (keyCode == UP) scale -= 0.02;
    if (keyCode == DOWN) scale += 0.02;
  }
}

