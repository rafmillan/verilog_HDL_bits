module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
    parameter A=0, B=1;
    reg state, next;
    reg [2:0] shift = 0, count = 0;
    
    
    always @ (*) begin
        case (state)
            A: next = s ? B : A;
            B: next = B;
        endcase
    end
    
    always @ (posedge clk) begin
        if (reset) state <= A;
        else state <= next;
    end
    
    always @ (posedge clk) begin
        if (reset) begin
            count <= 3'b0;
            shift <= 3'b0;
        end else if (next == B) begin
            shift <= {shift[1:0], w};
            if (count == 3) begin
                count <= 3'b1;
            end else count <= count + 1'b1;
        end
    end
    
    assign z = (count == 1) & (shift == 3'b011 | shift == 3'b101 | shift == 3'b110); 
     

endmodule
