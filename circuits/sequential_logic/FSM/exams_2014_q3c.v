module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);
    
    parameter A=0, B=1, C=2, D=3, E=4;
    reg [2:0] next;
    
    always @ (*) begin
        case (y)
            A: next = x ? B : A;
            B: next = x ? E : B;
            C: next = x ? B : C;
            D: next = x ? C : B;
            E: next = x ? E : D;
        endcase
    end
    
    assign Y0 = next[0];
    assign z = (y == D) || (y == E);
        
    

endmodule
