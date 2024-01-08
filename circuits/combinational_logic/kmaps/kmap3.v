/*

cd\ab 01 00 10 11
    00 x  0  1  1
    01 0  0  x  x
    11 0  1  1  1
    10 0  1  1  1

*/

module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  );
    
    assign out = (a | c) & (a | ~b);

endmodule
