/*
We want to add parity checking to the serial receiver.
Parity checking adds one extra bit after each data byte.
We will use odd parity, where the number of 1s in the 9 bits
received must be odd. For example, 101001011 satisfies odd parity
(there are 5 1s), but 001001011 does not.

Change your FSM and datapath to perform odd parity checking.
Assert the done signal only if a byte is correctly received and
its parity check passes. Like the serial receiver FSM, this FSM
needs to identify the start bit, wait for all 9 (data and parity)
bits, then verify that the stop bit was correct. If the stop bit
does not appear when expected, the FSM must wait until it finds a
stop bit before attempting to receive the next byte.

You are provided with the following module that can be used to
calculate the parity of the input stream (It's a TFF with reset).
The intended use is that it should be given the input bit stream,
and reset at appropriate times so it counts the number of 1 bits
in each byte.

module parity (
    input clk,
    input reset,
    input in,
    output reg odd);

    always @(posedge clk)
        if (reset) odd <= 0;
        else if (in) odd <= ~odd;

endmodule

Note that the serial protocol sends the least significant bit
first, and the parity bit after the 8 data bits.
*/

module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); 

    // Modify FSM and datapath from Fsm_serialdata
    parameter IDLE=0, START=1, D0=2, D1=3, D2=4, D3=5, D4=6, D5=7, D6=8, D7=9, PAR=10, DISC=11; 
    reg [3:0] state, next;
    reg [7:0] data;
    wire odd, reset_p;

    always@(*) begin
        case(state)
            IDLE: next = in ? IDLE : START;
            START: next = D0;
            D0: next = D1;
            D1: next = D2;
            D2: next = D3;
            D3: next = D4;
            D4: next = D5;
            D5: next = D6;
            D6: next = D7;
            D7: next = PAR;
            PAR: next = in ? IDLE : DISC;
            DISC: next = in ? IDLE : DISC;
        endcase
    end
    
    always@(posedge clk) begin
        if(reset) state <= IDLE;
        else state <= next;
    end

    always@(posedge clk) begin
        if(reset) begin
            reset_p <= 1'b1;
            done <= 1'b0;
        end
        else begin
            if (next == D0 | next == D1 | next == D2 | next == D3 | next == D4 | next == D5 | next == D6 | next == D7)
                out_byte <= {in, out_byte[7:1]};
            else if(next == START) begin
                reset_p <= 1'b0;
                done <= 1'b0;
            end  
            else if(next == IDLE)
                done <= odd;
            else if(next == PAR)
                reset_p <= 1'b1;
        end
    end   

    parity par_mod(clk, reset|reset_p, in, odd);

endmodule