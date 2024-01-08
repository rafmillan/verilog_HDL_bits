/*
 
cd\ab 00 01 11 10
    00 1  1  0  1
    01 1  0  0  1
    11 0  1  1  1
    10 1  1  0  0

*/

module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 
	
    assign out = (~a & ~d) | (b & c & d) | (a & ~b & ~c) | (a & ~b & d) | (~b & ~c & d);
    
endmodule
