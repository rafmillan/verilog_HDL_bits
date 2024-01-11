/*
Consider a finite state machine that is used to control some
type of motor. The FSM has inputs x and y, which come from the
motor, and produces outputs f and g, which control the motor.
There is also a clock input called clk and a reset input called
resetn.

The FSM has to work as follows. As long as the reset input is
asserted, the FSM stays in a beginning state, called state A.
When the reset signal is de-asserted, then after the next clock
edge the FSM has to set the output f to 1 for one clock cycle.
Then, the FSM has to monitor the x input. When x has produced the
values 1, 0, 1 in three successive clock cycles, then g should be
set to 1 on the following clock cycle. While maintaining g = 1 the
FSM has to monitor the y input. If y has the value 1 within at most
two clock cycles, then the FSM should maintain g = 1 permanently
(that is, until reset). But if y does not become 1 within two
clock cycles, then the FSM should set g = 0 permanently (until
reset).
*/

module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 
    parameter A=0, B=1, C=2, D=3, E=4, F=5, G=6, H=7, I=8;
    reg	[3:0] state, next;
    
    always @(*) begin
        case (state)
            A	:	next = resetn ? B : A;
            B	:	next = C;
            C	: 	next = x ? D : C;
            D	: 	next = x ? D : E;
            E	: 	next = x ? F : C;
            F	:	next = y ? G : H;
            G	: 	next = resetn ? G : A;
            H	: 	next = y ? G : I;
            I	: 	next = resetn ? I : A;
        endcase
    end
    
    always @(posedge clk) begin
        if (~resetn) state <= A;
        else state <= next;
    end
    
    always @(posedge clk) begin
        if (next == B )f <= 1'b1;
        else if (next == F | next == H | next == G ) g <= 1'b1;
        else if (next == I) g <= 1'b0;
        else begin
            g <= 1'b0;
            f <= 1'b0;
        end
    end

endmodule
