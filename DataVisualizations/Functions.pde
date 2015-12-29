//A008292: triangle of Eulerian numbers T(n,k) (n>=1, 1 <= k <= n) read by rows.
//http://oeis.org/A008292

//1, 1, 1, 1, 4, 1, 1, 11, 11, 1, 1, 26, 66, 26, 1, 1, 57, 302, 302, 57, 1, 1, 120, 1191, 2416, 1191, 
//120, 1, 1, 247, 4293, 15619, 15619, 4293, 247, 1, 1, 502, 14608, 88234, 156190, 88234, 14608, 502, 
//1, 1, 1013, 47840, 455192, 1310354, 1310354, 455192

//http://www.mathrecreation.com/2009/01/triangular-numbers-and-eulers-number.html

class EulersTriangle{
  
  int size;
  IntList sequence = new IntList();
  
  EulersTriangle(int size_){
    
    size = size_;
    
    for(int n = 1; n <= size; n++){
    
       nextNumbers(n); 
      
    }
    
    //println(sequence);
    
  }
 
  //A(n, 1) = A(n, n) = 1
  //A(n + 1, k) = k * A(n, k) + (n + 2 - k) * A(n, k - 1);
  void nextNumbers(int n_){
    
     //n_: current row (n + 1)
   
     int level = sequence.size() - n_ + 1;
     
     for(int k = 1; k <= n_; k++){ //k
       
     if(k == 1 || k > (n_ - 1)) { sequence.append(1); }  //A(n, 1) = 1
     else
     {
     
         //1 <= k <= n
         if(k - 1 >= 1){ 
         
         int Ank = sequence.get(level + k - 1); 
         int Ankmin = sequence.get(level + k - 2);

         sequence.append(k * Ank + ((n_ - 1) + 2 - k) * Ankmin); 
         //println(k * Ank + ((n_ - 1) + 2 - k) * Ankmin);
       
         }

     }
       
     }
 
  }
  
  String atIndex(int i_){
    
    String output = binary(sequence.get(i_), 64128);
    return output;
    
  }

  String[] getRow(int i_){
    
    
    String[] output = new String[i_];
    
    //e.g. 4: (1 + 2 + 3)
    int startingIndex = seq(i_);
    for(int s = 0; s < i_; s++){
    output[s] = binary(sequence.get(startingIndex + s), 128);
    }
    return output;
    
  }
  
  int seq(int s_){
  
      int l = 0;
      
      for(int i = 1; i < s_; i++){
       
        l += i;
        
      }
      
      println(l);
      
      return l;
    
  }
  
}

float ZTransform(float exp_, float n_, float z_){
  
  float output = 0.0;
 
  return output; 
  
}
  
  

