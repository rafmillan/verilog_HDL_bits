/*
Now that you have a finite state machine that can identify
when bytes are correctly received in a serial bitstream,
add a datapath that will output the correctly-received data byte.
out_byte needs to be valid when done is 1, and is don't-care
otherwise.

Note that the serial protocol sends the least significant bit first.
*/

module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    // Use FSM from Fsm_serial
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
    
    // New: Datapath to latch input bits.
    always @ (posedge clk) begin
        if (reset) out_byte <= 8'b0;
        else if (next != DISC & next != STOP & next != IDLE) begin
            out_byte <= {in, out_byte[7:1]};
        end
    end

endmodule
