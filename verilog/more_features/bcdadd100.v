/*
You are provided with a BCD one-digit adder named bcd_fadd that adds two BCD digits and carry-in, and produces a sum and carry-out.

module bcd_fadd (
    input [3:0] a,
    input [3:0] b,
    input     cin,
    output   cout,
    output [3:0] sum );

Instantiate 100 copies of bcd_fadd to create a 100-digit BCD ripple-carry adder.
Your adder should add two 100-digit BCD numbers (packed into 400-bit vectors) and a carry-in to produce a 100-digit sum and carry out.
*/

module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
    
    reg [99:0] couti;
    
    genvar i;
    generate
        for (i = 3; i < 400; i += 4) begin : bcd_adds
            if (i == 3) bcd_fadd add0 (a[i:i-3], b[i:i-3], cin, couti[(i/4)], sum[i: i-3]);
            else bcd_fadd addi (a[i:i-3], b[i:i-3], couti[(i/4)-1], couti[i/4], sum[i: i-3]);
        end
    endgenerate
    
    assign cout = couti[99];

endmodule
