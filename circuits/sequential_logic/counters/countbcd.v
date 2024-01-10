/*
Build a 4-digit BCD (binary-coded decimal) counter.
Each decimal digit is encoded using 4 bits: q[3:0]
is the ones digit, q[7:4] is the tens digit, etc.
For digits [3:1], also output an enable signal indicating
when each of the upper three digits should be incremented.

You may want to instantiate or modify some one-digit
decade counters.
*/

module dec_counter (
	input clk,
	input reset,
    input enable,
    output [3:0] q);

  always @(posedge clk) begin
    if (reset) q <= 0;
    else begin
      if (enable) begin
        if (q < 9) q <= q + 1;
        else q <= 0;
      end
    end
  end

endmodule

module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);
    
    dec_counter counter_ones (clk, reset, 1, q[3:0]);
    dec_counter counter_tens (clk, reset, ena[1], q[7:4]);
    dec_counter counter_hundreds (clk, reset, ena[2], q[11:8]);
    dec_counter counter_thousands (clk, reset, ena[3], q[15:12]);
    
    assign ena[1] = (q[3:0] == 9);
    assign ena[2] = ena[1] && (q[7:4] == 9);
    assign ena[3] = ena[2] && (q[11:8] == 9);
    
endmodule
