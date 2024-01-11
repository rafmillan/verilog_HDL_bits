module top_module (
    input clk,
    input w, R, E, L,
    output Q
);
    
    always @ (posedge clk) begin
        Q <= L ? R : (E ? w : Q);
    end

endmodule

module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); //
	
    muxdff dut0 (KEY[0], KEY[3], SW[3], KEY[1], KEY[2], LEDR[3]);
    muxdff dut1 (KEY[0], LEDR[3], SW[2], KEY[1], KEY[2], LEDR[2]);
    muxdff dut2 (KEY[0], LEDR[2], SW[1], KEY[1], KEY[2], LEDR[1]);
    muxdff dut3 (KEY[0], LEDR[1], SW[0], KEY[1], KEY[2], LEDR[0]);
    
endmodule

