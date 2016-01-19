/*

My interpretation of RealDigits() @ Wolfram's Mathematica

*/

int RealDigits(double input_, int base_, int len_, int d_, int element_){
  
   int out = 0; 
   
   ArrayList<Character> digits = new ArrayList<Character>();
   String number = String.valueOf((float)Math.abs(input_));
   number.replaceFirst("^0+(?!$)", "");
   
   for(int c = 0; c < number.length(); c++){
    
     if(Character.isDigit(number.charAt(c)) == true)  { digits.add(number.charAt(c)); }
     //if() digits.add(number.charAt[c]);
     
   }
     
   //if(digits.size() > 0 && digits.get(0) == '0') { digits.remove(0); }

   return Integer.parseInt(binary(digits.get(1), 1));
  
}
