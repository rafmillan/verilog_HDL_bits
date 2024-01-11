/*
Implement a Mealy-type finite state machine that recognizes
the sequence "101" on an input signal named x. Your FSM
should have an output signal, z, that is asserted to logic-1
when the "101" sequence is detected. Your FSM should also have
an active-low asynchronous reset. You may only have 3 states
in your state machine. Your FSM should recognize overlapping
sequences.
*/

module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 
    
    parameter A=0, B=1, C=2;
    reg [1:0] state, next;
    
    always @ (*) begin
        z = 0;
        case (state)
            A: next = x ? B : A;
            B: next = x ? B : C;
            C: begin
                if (x) begin
                    next = B;
                    z = 1;
                end
                else next = A;
            end
        endcase
    end
    
    always @ (posedge clk or negedge aresetn) begin
        if (!aresetn) state <= A;
        else state <= next;
    end

endmodule
