/*
 a  0   1
bc
00  0   1
01  1   1
11  1   1
10  1   1
*/

module top_module(
	input a, 
	input b,
	input c,
	output out
);
	assign out = (a | b | c);
	
endmodule