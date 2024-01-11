module dfff (
    input clk,
    input reset,            // Synchronous reset
    input d,
    output q
);
    
    always @ (posedge clk) begin
        q <= (!reset) ? 0 : d;
    end 

endmodule


module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
    
    wire q1, q2, q3;
    
    dfff d1 (clk, resetn, in, q1);
    dfff d2 (clk, resetn, q1, q2);
    dfff d3 (clk, resetn, q2, q3);
    dfff d4 (clk, resetn, q3, out);
    
endmodule