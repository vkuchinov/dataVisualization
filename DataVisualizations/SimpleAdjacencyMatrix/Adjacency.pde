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
               for(int i = 0; i < g.nodes.size(); i++){
                 
                      //PVector p1 = points.get(i);
                      //PVector p2 = points.get(j);
                      fill(255);
                      if(j == i) fill(255);
                      for(int c = 0; c < g.connections.length; c++){
                          if((g.connections[c].x == j && g.connections[c].y == i) || (g.connections[c].x == i && g.connections[c].y == j)) fill(0);
                      }
                      rect(x + i * step, y + j * step, step, step);
                 
               }
           }
       
     }

}
