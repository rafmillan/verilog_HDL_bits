/*
You are provided with a BCD (binary-coded decimal)
one-digit adder named bcd_fadd that adds two BCD digits
and carry-in, and produces a sum and carry-out.

module bcd_fadd (
    input [3:0] a,
    input [3:0] b,
    input     cin,
    output   cout,
    output [3:0] sum );

Instantiate 4 copies of bcd_fadd to create a 4-digit BCD ripple-carry adder.
Your adder should add two 4-digit BCD numbers (packed into 16-bit vectors)
and a carry-in to produce a 4-digit sum and carry out.
*/

module top_module ( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );
    
    wire [2:0] couti;
    
    bcd_fadd add0 (a[3:0], b[3:0], cin, couti[0], sum[3:0]);
    bcd_fadd add2 (a[7:4], b[7:4], couti[0], couti[1], sum[7:4]);
    bcd_fadd add3 (a[11:8], b[11:8], couti[1], couti[2], sum[11:8]);
    bcd_fadd add4 (a[15:12], b[15:12], couti[2], cout, sum[15:12]);

endmodule
