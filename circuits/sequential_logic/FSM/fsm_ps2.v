/*
The PS/2 mouse protocol sends messages that are three bytes long.
However, within a continuous byte stream, it's not obvious where
messages start and end. The only indication is that the first byte
of each three byte message always has bit[3]=1 (but bit[3] of the
other two bytes may be 1 or 0 depending on data).

We want a finite state machine that will search for message
boundaries when given an input byte stream. The algorithm we'll
use is to discard bytes until we see one with bit[3]=1. We then
assume that this is byte 1 of a message, and signal the receipt
of a message once all 3 bytes have been received (done).

The FSM should signal done in the cycle immediately after the
third byte of each message was successfully received.
*/

module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done); //
    
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
    
endmodule
