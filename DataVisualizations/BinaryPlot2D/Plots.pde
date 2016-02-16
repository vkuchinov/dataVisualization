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
