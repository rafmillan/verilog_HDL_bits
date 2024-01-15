/*
This is the fourth component in a series of five exercises that
builds a complex counter out of several smaller circuits.
See the final exercise for the overall design.

You may wish to do FSM: Enable shift register and FSM: Sequence recognizer first.

We want to create a timer that:

    1. is started when a particular pattern (1101) is detected,
    2. shifts in 4 more bits to determine the duration to delay,
    3. waits for the counters to finish counting, and
    4. notifies the user and waits for the user to acknowledge the timer.

In this problem, implement just the finite-state machine that controls the timer.
The data path (counters and some comparators) are not included here.

The serial data is available on the data input pin. When the pattern 1101 is received,
the state machine must then assert output shift_ena for exactly 4 clock cycles.

After that, the state machine asserts its counting output to indicate it is
waiting for the counters, and waits until input done_counting is high.

At that point, the state machine must assert done to notify the user the timer
has timed out, and waits until input ack is 1 before being reset to look for the
next occurrence of the start sequence (1101).

The state machine should reset into a state where it begins searching for the
input sequence 1101.

Here is an example of the expected inputs and outputs. The 'x' states may be
slightly confusing to read. They indicate that the FSM should not care about
that particular input signal in that cycle. For example, once a 1101 pattern
is detected, the FSM no longer looks at the data input until it resumes searching
after everything else is done.
*/

module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );
    
    parameter A=0, B=1, C=2, D=3, E0=4, E1=5, E2=6, E3=7, COUNT=8, WAIT=9;
    reg [3:0] state, next;
    
    always @ (*) begin
        case (state)
            A		: next = data ? B : A;
            B		: next = data ? C : A;
            C		: next = data ? C : D;
            D		: next = data ? E0 : A;
       		E0		: next = E1;
            E1		: next = E2;
            E2		: next = E3;
            E3		: next = COUNT;
            COUNT	: next = done_counting ? WAIT : COUNT;
            WAIT	: next = ack ? A : WAIT;
        endcase
    end
    
    always @ (posedge clk) begin
        if (reset)
            state <= A;
        else
            state <= next;
    end
    
    assign shift_ena = state == E0 | state == E1 | state == E2 | state == E3;
    assign counting = state == COUNT;
    assign done = state == WAIT;
    

endmodule
