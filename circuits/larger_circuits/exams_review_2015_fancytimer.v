/*
This is the fifth component in a series of five exercises that builds a
complex counter out of several smaller circuits. You may wish to do the
four previous exercises first (counter, sequence recognizer FSM, FSM delay,
and combined FSM).

We want to create a timer with one input that:

    1. is started when a particular input pattern (1101) is detected,
    2. shifts in 4 more bits to determine the duration to delay,
    3. waits for the counters to finish counting, and
    4. notifies the user and waits for the user to acknowledge the timer.

The serial data is available on the data input pin. When the pattern 1101 is received,
the circuit must then shift in the next 4 bits, most-significant-bit first.
These 4 bits determine the duration of the timer delay. I'll refer to this as
the delay[3:0].

After that, the state machine asserts its counting output to indicate it is counting.
The state machine must count for exactly (delay[3:0] + 1) * 1000 clock cycles. e.g.,
delay=0 means count 1000 cycles, and delay=5 means count 6000 cycles. Also output the
current remaining time. This should be equal to delay for 1000 cycles, then delay-1
for 1000 cycles, and so on until it is 0 for 1000 cycles. When the circuit isn't
counting, the count[3:0] output is don't-care (whatever value is convenient for you
to implement).

At that point, the circuit must assert done to notify the user the timer has timed
out, and waits until input ack is 1 before being reset to look for the next occurrence
of the start sequence (1101).

The circuit should reset into a state where it begins searching for the input sequence 1101.
*/

module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );
    
    parameter S=0, S1=1, S11=2, S110=3, B0=4, B1=5, B2=6, B3=7, COUNT=8, WAIT=9;
    reg [3:0] state, next, delay;
    reg done_counting;
    reg shift_ena;
    
    // FSM
    always @ (*) begin
        case (state)
            S		: next = data ? S1 : S;
            S1		: next = data ? S11 : S;
            S11		: next = data ? S11 : S110;
            S110	: next = data ? B0: S;
            B0		: next = B1;
            B1		: next = B2;
            B2		: next = B3;
            B3		: next = COUNT;
            COUNT	: next = done_counting ? WAIT : COUNT;
            WAIT	: next = ack ? S : WAIT;
        endcase
    end
    
    always @ (posedge clk) begin
        if (reset) state <= S;
        else state <= next;
    end
    
    // 1000 COUNTER
    reg [9:0] count1000;
    always @ (posedge clk) begin
        if (reset | count1000 == 999) count1000 <= 10'b0;
        else if (counting) count1000 <= count1000 + 1'b1;
    end
    
    // SHIFT AND COUNT
    always @ (posedge clk) begin
        if (count1000 == 999) delay = delay - 1'b1;
        else if (shift_ena) begin
            delay = {delay[2:0], data};
        end
    end
    
    assign shift_ena = (state == B0) | (state == B1) | (state == B2) | (state == B3);
   	assign counting = (state == COUNT);
    assign done = (state == WAIT);       
    assign count = delay;
    assign done_counting = (delay == 0 & count1000 == 999) ? 1'b1 : 1'b0;

endmodule

