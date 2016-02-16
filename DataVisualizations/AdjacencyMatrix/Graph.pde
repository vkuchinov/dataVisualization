import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

class Graph{
  
       PVector[] nodes, connections;
       
       Graph(String url_){
        
           //nodes have x,y values
           XML xml = loadXML(URL);
           XML[] xmlPoints = xml.getChildren("circle");
     
           nodes = new PVector[xmlPoints.length];
           
           for (int p = 0; p < xmlPoints.length; p++) {
             
                nodes[p] = new PVector(Float.parseFloat(xmlPoints[p].getString("cx")), Float.parseFloat(xmlPoints[p].getString("cy"))); 
             
           }
    
           //connections node1, node2
           XML[] xmlLines = xml.getChildren("line");
    
           connections = new PVector[xmlLines.length];
           
           for (int p = 0; p < xmlLines.length; p++) {
           
                int[] pairing = getNodes(xmlLines[p]);
                if(pairing[0] != Integer.MIN_VALUE && pairing[1] != Integer.MIN_VALUE){
                connections[p] = new PVector(pairing[0], pairing[1]); }
                else{
                println("broken connection");
                }
  
           }
        
       } 
       
       int[] getNodes(XML string_){
         
            int[] output = { Integer.MIN_VALUE, Integer.MIN_VALUE };
            
            PVector p0 = new PVector(Float.parseFloat(string_.getString("x1")), Float.parseFloat(string_.getString("y1")));
            PVector p1 = new PVector(Float.parseFloat(string_.getString("x2")), Float.parseFloat(string_.getString("y2")));
         
            for(int n = 0; n < nodes.length; n++){
              
                  if(PVector.dist(p0, nodes[n]) < 0.1) output[0] = n;
                  if(PVector.dist(p1, nodes[n]) < 0.1) output[1] = n;
              
            }
            return output; 
       }
       
       void Dijkstras(){
         
         
         
       }
  
}

class Node{
  
     Node(){
      
      
     } 
  
}
