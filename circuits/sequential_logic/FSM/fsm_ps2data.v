/*
Now that you have a state machine that will identify three-byte
messages in a PS/2 byte stream, add a datapath that will also
output the 24-bit (3 byte) message whenever a packet is received
(out_bytes[23:16] is the first byte, out_bytes[15:8] is the
second byte, etc.).

out_bytes needs to be valid whenever the done signal is asserted.
You may output anything at other times (i.e., don't-care).
*/

module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    // FSM from fsm_ps2
	parameter A=0, B=2, C=3, D=4;
    reg [2:0] state, next;

    // State transition logic (combinational)
    always @ (*) begin
        case (state)
            A: next = in[3] ? B : A;
            B: next = C;
            C: next = D;
            D: next = in[3] ? B : A;
        endcase
    end

    // State flip-flops (sequential)
    always @ (posedge clk) begin
        if (reset) state <= A;
        else state <= next;
    end
 
    // Output logic
	assign done = state == D;

    // New: Datapath to store incoming bytes.
    always @ (posedge clk) begin
        if (reset) out_bytes = 23'b0;
        else out_bytes = {out_bytes[16:0], in[7:0]};
    end

endmodule
