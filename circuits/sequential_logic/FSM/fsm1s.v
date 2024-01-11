module top_module(
    input clk,
    input reset,    // Asynchronous reset to state B
    input in,
    output out);//  

    parameter A=0, B=1; 
    reg state, next_state;

    always @(*) begin    // This is a combinational always block
        case (state)
            1'b1: next_state = in ? B : A;
            1'b0: next_state = in ? A : B;
        endcase
    end

    always @(posedge clk) begin    // This is a sequential always block
        // State flip-flops with asynchronous reset
        if (reset) state <= B;
        else state <= next_state;
    end

    // Output logic
    assign out = (state == B);

endmodule
