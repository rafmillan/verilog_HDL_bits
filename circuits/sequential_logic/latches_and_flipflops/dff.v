/*
A D flip-flop is a circuit that stores a bit and is updated periodically,
at the (usually) positive edge of a clock signal.

D flip-flops are created by the logic synthesizer when a clocked always
block is used (See alwaysblock2). A D flip-flop is the simplest form of
"blob of combinational logic followed by a flip-flop" where the combinational
logic portion is just a wire.

Create a single D flip-flop.
*/

module top_module (
    input clk,    // Clocks are used in sequential circuits
    input d,
    output reg q );//

    always @ (posedge clk) begin
        q <= d;
    end

endmodule