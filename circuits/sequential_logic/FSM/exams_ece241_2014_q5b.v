/*
The following diagram is a Mealy machine implementation of the 2's complementer.
Implement using one-hot encoding.
*/

module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    
    parameter A=0, B=1;
    reg state, next;
    
    always @ (*) begin
        case (state)
            A: 	begin
                	if (x) begin
                    	next = B;
                    	z = 1;
                	end else begin
                    	next = A;
                    	z = 0;
                	end
            	end
            B:	begin
                	if (x) begin
                        next = B;
                        z = 0;
                	end else begin
                        next = B;
                        z = 1;
                    end
            end
        endcase
    end
    
    always @ (posedge clk or posedge areset) begin
        if (areset) state <= A;
        else state <= next;
    end

endmodule
