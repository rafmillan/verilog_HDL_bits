/*
You are to design a one-input one-output serial 2's complementer
Moore state machine. The input (x) is a series of bits
(one per clock cycle) beginning with the least-significant
bit of the number, and the output (Z) is the 2's complement
of the input. The machine will accept input numbers of arbitrary
length. The circuit requires an asynchronous reset.
The conversion begins when Reset is released and stops when
Reset is asserted.
*/

module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    
    parameter A=0, B=1, C=2;
    reg [1:0] state, next;
    
    always @ (*) begin
        case (state)
            A: next = x ? B : A;
            B: next = x ? C : B;
            C: next = x ? C : B;
        endcase
    end
    
    always @ (posedge clk or posedge areset) begin
        if (areset) state <= A;
        else state <= next;
    end
    
    assign z = (state == B) ? 1 : 0;

endmodule
