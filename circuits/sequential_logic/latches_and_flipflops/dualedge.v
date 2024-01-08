/*
You're familiar with flip-flops that are triggered on the
positive edge of the clock, or negative edge of the clock.
A dual-edge triggered flip-flop is triggered on both edges
of the clock. However, FPGAs don't have dual-edge triggered
flip-flops, and always @(posedge clk or negedge clk) is not
accepted as a legal sensitivity list.

Build a circuit that functionally behaves like a dual-edge triggered flip-flop
*/

module top_module (
    input clk,
    input d,
    output q
);
    reg p, n;
    always @ (posedge clk) begin
        p <= d ^ n;
    end
    
    always @ (negedge clk) begin
        n <= d ^ p;
    end
    
    assign q = p ^ n;

endmodule
