/*
In many (older) serial communications protocols,
each data byte is sent along with a start bit and a stop bit,
to help the receiver delimit bytes from the stream of bits.
One common scheme is to use one start bit (0), 8 data bits,
and 1 stop bit (1). The line is also at logic 1 when nothing
is being transmitted (idle).

Design a finite state machine that will identify when bytes
have been correctly received when given a stream of bits.
It needs to identify the start bit, wait for all 8 data bits,
then verify that the stop bit was correct. 

If the stop bit does not appear when expected,
the FSM must wait until it finds a stop bit before
attempting to receive the next byte.
*/

module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 
    
    parameter  IDLE=0, START=1, D0=2, D1=3, D2=4, D3=5, D4=6, D5=7, D6=8, D7=9, DISC=10, STOP=11;
    reg [3:0] state, next;
    
    always @ (*) begin
        case (state)
            IDLE	: next = in ? IDLE : START;
            START	: next = D0;
            D0		: next = D1;
            D1		: next = D2;
            D2		: next = D3;
            D3		: next = D4;
            D4		: next = D5;
            D5		: next = D6;
            D6		: next = D7;
            D7		: next = in ? STOP : DISC;
            DISC	: next = in ? IDLE : DISC;
            STOP	: next = in ? IDLE : START;
        endcase
    end
    
    always @ (posedge clk) begin
        if (reset) state <= IDLE;
        else state <= next;
    end
    
    assign done = state == STOP;

endmodule
