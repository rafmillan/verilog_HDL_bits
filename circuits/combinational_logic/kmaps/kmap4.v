/*

cd\ab 00 01 11 10
    00 0  1  0  1
    01 1  0  1  0
    11 0  1  0  1
    10 0  1  0  1

*/

module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 
    
    assign out = a ^ b ^ c ^ d;

endmodule
