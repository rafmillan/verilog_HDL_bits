`define CLK 10
module top_module ();
    reg clk;
    initial clk = 0;
    always #(`CLK/2) clk = ~clk;
    
    reg reset, t, q;
    
    initial begin
    	reset = 1'b1;
        t = 0;
        #10 reset = 1'b0;
        #5 t = 1;
    end
    
    tff dut (clk, reset, t, q);

endmodule
