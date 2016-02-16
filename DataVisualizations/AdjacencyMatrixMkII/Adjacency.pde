class Adjacency{
  
     float x, y, w, h, step; 
     float min = 0; float max = Float.MIN_VALUE;

     Graph g;
     
     Adjacency(float x_, float y_, float w_, Graph g_){
  
           x = x_; y = y_; w = w_; h = w_;
           step = w / g_.nodes.size();
           
           g = g_;
           
           //maximum connections in graph to get from one node to another
           //minimal is 0 [itself]
           setMax();
     }   
     
     void setMax(){
       
           //distance algorith????
           //short (optimal) distance in a graph?
           //Dijkstra's algorithm
           //Shortest Path Problem
       
     }

     void draw(){
      
           rectMode(CORNER);
           fill(255);
           noStroke();
           rect(x, y, w, h);
           
           for(int j = 0; j < g.nodes.size(); j++){
             
               strokeWeight(0.5);
               stroke(0);
               
               line(50, 24 + 18 * j, 300, 24 + 18 * j);
               line(300, 24 + 18 * j, 309, 24 + 9 + 18 * j);
               line(309, 24 + 9 + 18 * j, 300, 24 + 18 + 18 * j); 
               
               if(j != 0) line(309, 24 + 9 - 18 + 18 * j, 309 + (9 * g.nodes.size() - (j - 1) * 9) - 9, 24 + (18*(g.nodes.size()+1))/2.0 + 18 * j - j * 9 - 18);
               line(309, 24 + 9 - 18 + 18 * j + 18, 309 + (j * 9), 24 + 18 * j - j * 9 + 9);
               
               fill(0);
               noStroke();
               textSize(9);
               textAlign(RIGHT, CENTER);
               text(g.nodes.get(j).name, 300, 32 + 18 * j);
               stroke(0);
               noFill();
                
               for(int i = j + 1; i < g.nodes.size(); i++){
                 
                      noFill();
                      //if(i <= j){
                  
                    
                      if(i != j && checkConnection(g.nodes.get(i), g.nodes.get(j))) strokeWeight(8.0); else strokeWeight(2.5);
                      point(300 + i * 9 - j*9 , 33 + j * 9 + i * 9);

                      //fill(0);
                      //noStroke();
                      //textSize(4);
                      //textAlign(CENTER, CENTER);
                      //text(j + ", " + i, 300 + i * 9 - j*9 , 33 + j * 9 + i * 9);
                      //text(i + ", " + j, 318 + i * 18, 33 + 18 + j * 18);
                      
               }
           }
       
           stroke(0);
           strokeWeight(0.5);
           line(50, 24, 300, 24);
           line(300, 6 + 18, 309, 6 + 9 + 18);
           line(309, 6 + 9 + 18, 300, 6 + 18 + 18);
           line(50, 24 + 18 * g.nodes.size(), 300, 24 + 18 * g.nodes.size());
          
     }
     
     boolean checkConnection(Node n1, Node n2){
       
           for(int c = 0; c < g.connections.length; c++){
            
                if((n1.index == (int)g.connections[c].x && n2.index == (int)g.connections[c].y) || ((n2.index == (int)g.connections[c].x && n1.index == (int)g.connections[c].y))) return true; 
             
           }
       
           return false;
           
     }

}
