/*


convert_lossless(x)

Attempt to convert x to an mpf or mpc losslessly. 
If x is anmpf or mpc, return it unchanged. 
If x is an int, create an mpf with
sufficient precision to represent it exactly. 

If x is a str, just convert it to an mpf with the current 
working precision (perhaps this should be done differently...)

What is mpf or mpc?

mpf: real float
mpc: real complex

FLOAT, REAL and DOUBLE

FLOAT data type is used to store single-precision and 
double-precision floating-point numbers.

REAL single-precision floating-point number.

DOUBLE [PRECISION] double-precision floating-point number.

What is agm(a, b)?

agm : arithmetic-geometric mean

What is eps? epsilon? yes 2.22045e-16

 a, b = (a+b)*half, (a*b)**half
 
 a = (a+b) * half, b = pow((a*b), half) ????
 

*/
