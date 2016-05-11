/*

SPIROLATERAL
another dimension of Turtle graphics

A figure formed by taking a series of steps of length 1, 2, ..., n, 
with an angle  theta turn after each step. The symbol for 
a spirolateral is ^(a_1,...,a_k)n_theta, where the a_is indicate 
that turns are in the -theta direction for these steps.

Spirolaterals are geometrical figures formed by the repetition of a simple rule. 
The base pattern is formed by drawing line segments of increasing length (in integer units) 
up to a particular size, turning a fixed angle after each segment (clockwise or anti-clockwise). 
Drawing continues in the same manner from the resulting position until either the figure so 
created returns to its starting point, or it becomes apparent that it will never do so.

For example, consider a 3 segment, 90 degree process. The figure below shows each complete cycle 
in the process in bright red (three line segments of lengths 1, 2 and 3, with a left hand turn of 
90 degrees between each segment), and that after four cycles, the line returns to the starting point 
thus closing the figure.


REFERENCES:
http://mathworld.wolfram.com/Spirolateral.html
http://thewessens.net/ClassroomApps/Main/spirolaterals.html?topic=geometry&id=10

http://artgorithms.droppages.com/Software !!!!
https://www.ics.uci.edu/~eppstein/junkyard/topic.html !!!!
http://www.dataisnature.com/

http://thewessens.net/ClassroomApps/Main/js/spirolaterals.js


@author  Vladimir V. KUCHINOV
@email   helloworld@vkuchinov.co.uk

*/

Spirolateral spiro;

void setup(){
 
     size(600, 600, "processing.core.PGraphicsRetina2D"); 
     translate(width/2, height/2);
     
     spiro = new Spirolateral(5, 60.0, new int[]{2, 3});
     spiro.calculate(16);
}
