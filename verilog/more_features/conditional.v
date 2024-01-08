/*
Verilog has a ternary conditional operator ( ? : ) much like C:

(condition ? if_true : if_false)

This can be used to choose one of two values based on condition (a mux!) on one line, without using an if-then inside a combinational always block.

Examples:

(0 ? 3 : 5)     // This is 5 because the condition is false.
(sel ? b : a)   // A 2-to-1 multiplexer between a and b selected by sel.

always @(posedge clk)         // A T-flip-flop.
  q <= toggle ? ~q : q;

always @(*)                   // State transition logic for a one-input FSM
  case (state)
    A: next = w ? B : A;
    B: next = w ? A : B;
  endcase

assign out = ena ? q : 1'bz;  // A tri-state buffer

((sel[1:0] == 2'h0) ? a :     // A 3-to-1 mux
 (sel[1:0] == 2'h1) ? b :
                      c )

A Bit of Practice

Given four unsigned numbers, find the minimum.
Unsigned numbers can be compared with standard comparison operators (a < b).
Use the conditional operator to make two-way min circuits, then compose a few of them to create a 4-way min circuit.
You'll probably want some wire vectors for the intermediate results.
*/

module top_module (
    input [7:0] a, b, c, d,
    output [7:0] min);//

    wire [7:0] m1, m2;
    assign m1 = (a < b) ? a : b;
    assign m2 = (c < d) ? c : d;
    assign min = (m1 < m2) ? m1 : m2; 

endmodule
