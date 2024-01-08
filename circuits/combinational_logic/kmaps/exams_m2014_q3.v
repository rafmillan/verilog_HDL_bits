/*

x3x4\x1x2   00 01 11 10
        00   x  0  x  x
        01   0  x  1  0
        11   1  1  x  x
        10   1  1  0  x

*/

module top_module (
    input [4:1] x, 
    output f );
    
    assign f = (~x[1] & x[3]) | (x[2] & ~x[3] & x[4]);

endmodule
