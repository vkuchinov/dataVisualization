<h1>DATA VISUALIZATION</h1>
an ongoing research based on 
<i>http://mathworld.wolfram.com/topics/DataVisualization.html</i><br><br>

<table border="0" style="background-color:#FFFFFF;border-collapse:collapse;border:0px solid #FFCC00;color:#000000;width:520" cellpadding="0" cellspacing="0">
	<tr>
		<td>[-] Anti-Aliasing</td>
		<td>[-] Moiré Pattern</td>
		<td>[-] Simplex Plot</td>
	</tr>
	<tr>
		<td>[-] Antialiasing</td>
		<td>[-] Ordinate</td>
		<td>[-] Slope Field</td>
	</tr>
	<tr>
		<td>[-] Bar Chart</td>
		<td>[-] Phase Curve</td>
		<td>[-] Sparkline</td>
	</tr>
	<tr>
		<td>[x] Binary Plot</td>
		<td>[-] Phase Flow</td>
		<td>[-] Strang's Strange Figures</td>
	</tr>
	<tr>
		<td>[-] Cartesian Plot</td>
		<td>[-] Phase Plane</td>
		<td>[-] Surface of Section</td>
	</tr>
	<tr>
		<td>[-] Data Cube</td>
		<td>[-] Phase Portrait</td>
		<td>[-] Ternary Diagram</td>
	</tr>
	<tr>
		<td>[-] de Finetti Diagram</td>
		<td>[-] Phase Space</td>
		<td>[-] Ternary Graph</td>
	</tr>
	<tr>
		<td>[!] Equipotential Curve</td>
		<td>[-] Pie Chart</td>
		<td>[-] Ternary Plot</td>
	</tr>
	<tr>
		<td>[-] Function Graph</td>
		<td>[-] Poincaré Section</td>
		<td>[-] Tetraview</td>
	</tr>
	<tr>
		<td>[-] Inside-Outside Plot</td>
		<td>[x] Pólya Plot</td>
		<td>[-] Triangle Plot</td>
	</tr>
	<tr>
		<td>[-] Level Curve</td>
		<td>[-] Recurrence Plot</td>
		<td>[-] Tupper's Self-Referent</td>
	</tr>
	<tr>
		<td>[-] Level Set</td>
		<td>[x] Saunders Graphic</td>
		<td>[-] Vector Field</td>
	</tr>
	<tr>
		<td>[-] Level Surface</td>
		<td>[-] Scatter Diagram</td>
		<td>[-] Web Diagram</td>
	</tr>
	<tr>
		<td>[-] Log-Log Plot</td>
		<td>[-] Scatter Plot</td>
		<td>[-] World Line</td>
	</tr>
	<tr>
		<td>[-] Log Plot</td>
		<td>[-] Scatterplott</td>
		<td>[x] Complex Plot</td>
	</tr>
</table>

 [x] done [!] work in progress [-] planning

<br>
<b>BinaryPlot & Euler's Triangle Numbers Example</b>

<i>Syntax: BinaryPlot(String[] data_, int dim_, float size_);</i>

Excellent visualization for symetric number sequences like Euler's Triangle Numbers, Losanitsch's Triangle or Pascal's Triangle...
see reference image @ /References/BinaryPlotExample.png

![alt tag](https://raw.githubusercontent.com/vkuchinov/dataVisualization/master/DataVisualizations/References/BinaryPlotExample.png)<br><br>

<br>
<b>Tupper's Self-Referent</b><br>
<i>The Everything Formula | The Formula of Everything<i>

<i>Syntax: EverythingFormula();</i>

A self-referented plot. Displays original formula with this dataset of 543 integers:
<br><br><i>
960 939 379 918 958 884 971 672 962 127 852 754 715 004<br>
339 660 129 306 651 505 519 271 702 802 395 266 424 689<br> 
642 842 174 350 718 121 267 153 782 770 623 355 993 237<br> 
280 874 144 307 891 325 963 941 337 723 487 857 735 749<br> 
823 926 629 715 517 173 716 995 165 232 890 538 221 612<br> 
403 238 855 866 184 013 235 585 136 048 828 693 337 902<br> 
491 454 229 288 667 081 096 184 496 091 705 183 454 067<br> 
827 731 551 705 405 381 627 380 967 602 565 625 016 981<br> 
482 083 418 783 163 849 115 590 225 610 003 652 351 370<br> 
343 874 461 848 378 737 238 198 224 849 863 465 033 159<br> 
410 054 974 700 593 138 339 226 497 249 461 751 545 728<br> 
366 702 369 745 461 014 655 997 933 798 537 483 143 786<br> 
841 806 593 422 227 898 388 722 980 000 748 404 719<br></i>
<br>
see reference image @ /References/TuppersSelfReferent.png

![alt tag](https://raw.githubusercontent.com/vkuchinov/dataVisualization/master/DataVisualizations/References/TuppersSelfReferent.png)<br><br>

<br>
<b>Complex Plot 2D / 3D</b><br>
<i>implementation of complex plots<i>

<br>In complex plot X axis equals to Re (real part) and Y axis to Im (imaginary part).
The result of function is represented by Z axis.<br>
 
<i>Syntax: ComplexPlot(dimension, # of points [density], float[]{ minX, maxX},  float[]{ minY, maxY});</i>

![alt tag](https://raw.githubusercontent.com/vkuchinov/dataVisualization/master/DataVisualizations/ComplexPlane2D/screenshot.png)<br>
![alt tag](https://raw.githubusercontent.com/vkuchinov/dataVisualization/master/DataVisualizations/ComplexPlane3D/screenshot.png)<br><br>

<br>
<b>Saunder's Graphics [Plot]</b><br>
<i>a binary plot<i>

![alt tag](https://raw.githubusercontent.com/vkuchinov/dataVisualization/master/DataVisualizations/SaundersGraphics/screenshot.png)<br><br>

<br>
<b>Equipotential Plot</b><br>
<i>based on equipotential curves<i>

![alt tag](https://raw.githubusercontent.com/vkuchinov/dataVisualization/master/DataVisualizations/EquipotentialPlots/screenshot.png)<br><br>
