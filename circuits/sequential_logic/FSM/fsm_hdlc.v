/*
Synchronous HDLC framing involves decoding a continuous bit
stream of data to look for bit patterns that indicate the
beginning and end of frames (packets). Seeing exactly 6
consecutive 1s (i.e., 01111110) is a "flag" that indicate frame
boundaries. To avoid the data stream from accidentally containing
"flags", the sender inserts a zero after every 5 consecutive 1s
which the receiver must detect and discard. We also need to
signal an error if there are 7 or more consecutive 1s.

Create a finite state machine to recognize these three sequences:

0111110: Signal a bit needs to be discarded (disc).
01111110: Flag the beginning/end of a frame (flag).
01111111...: Error (7 or more 1s) (err).

When the FSM is reset, it should be in a state that behaves as
though the previous input were 0.
*/

module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);
    
    parameter RDY=0, D1=1, D2=2, D3=3, D4=4, D5=5, D6=6, ERR=7, DISC=8, FLAG=9;
    reg [3:0] state, next;
    
    always @ (*) begin
        case (state)
            RDY	: next = in ? D1 : RDY;
            D1	: next = in ? D2 : RDY;
            D2	: next = in ? D3 : RDY;
            D3	: next = in ? D4 : RDY;
            D4	: next = in ? D5 : RDY;
            D5	: next = in ? D6 : DISC;
            D6	: next = in ? ERR : FLAG;
            DISC: next = in ? D1 : RDY;
            FLAG: next = in ? D1 : RDY;
            ERR	: next = in ? ERR : RDY;
        endcase
    end
    
    always @ (posedge clk) begin
        if (reset) state <= RDY;
        else state <= next;
    end
    
    assign disc = state == DISC;
    assign flag = state == FLAG;
    assign err = state == ERR;

endmodule
