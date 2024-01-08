/*

x3x4\x1x2   00 01 11 10
        00   1  0  0  1
        01   0  0  0  0
        11   1  1  1  0
        10   1  1  0  1

*/

module top_module (
    input [4:1] x,
    output f
); 
    
    assign f = (~x[2] & ~x[4]) | (~x[1] & x[3]) | (x[2] & x[3] & x[4]);

endmodule
