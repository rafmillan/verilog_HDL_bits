/*
A "population count" circuit counts the number of '1's in an input vector.
Build a population count circuit for a 255-bit input vector.
*/

module top_module (
	input [254:0] in,
	output reg [7:0] out
);

	always @ (*) begin
		out = 0;
		for (int i=0;i<255;i++) begin
			out = out + in[i];
        end
	end
	
endmodule
