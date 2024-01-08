/*
Create a 100-bit binary ripple-carry adder by instantiating 100 full adders.
The adder adds two 100-bit numbers and a carry-in to produce a 100-bit sum and carry out.
To encourage you to actually instantiate full adders, also output the carry-out from each full adder in the ripple-carry adder.
cout[99] is the final carry-out from the last full adder, and is the carry-out you usually see.
*/

module fadd( 
    input a, b, cin,
    output cout, sum );

    assign sum = (a ^ b) ^ cin;
    assign cout = (a & b) | (cin  & (a ^ b));
endmodule

module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );

    genvar i;
    generate
        for (i = 0; i < 100; i++) begin: adders
            if (i == 0) fadd add0 (a[i], b[i], cin, cout[i], sum[i]);
            end else fadd addi (a[i], b[i], cout[i-1], cout[i], sum[i]);
        end
    endgenerate
    
endmodule

