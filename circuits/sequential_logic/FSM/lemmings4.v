/*
See also: Lemmings1, Lemmings2, and Lemmings3.

Although Lemmings can walk, fall, and dig, Lemmings aren't
invulnerable. If a Lemming falls for too long then hits the
ground, it can splatter. In particular, if a Lemming falls
for more than 20 clock cycles then hits the ground, it will
splatter and cease walking, falling, or digging (all 4 outputs
become 0), forever (Or until the FSM gets reset). There is no
upper limit on how far a Lemming can fall before hitting the
ground. Lemmings only splatter when hitting the ground; they
do not splatter in mid-air.

Extend your finite state machine to model this behaviour.

Falling for 20 cycles is survivable:
*/

module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
    
    parameter L=0, R=1, FL=2, FR=3, DL=4, DR=5, SPLAT=6;
    reg [2:0] state, next;
    reg [31:0] count;

    always @(*) begin
        case (state)
            L: begin
                if (ground)
                    if (dig)
                        next = DL;
                	else
                    	next = bump_left ? R : L;
                else
                    next = FL;
            end
            R: begin
                if (ground)
                    if (dig)
                        next = DR;
                    else
                        next = bump_right ? L : R;
                else
                    next = FR;
            end
            FL: begin
                if (ground) begin
                    if (count > 19) next = SPLAT;
                    else next = L;
                end
                else next = FL;
            end
            FR: begin
                if (ground) begin
                    if (count > 19) next = SPLAT;
                    else next = R;
                end
                else next = FR;
            end
            DL: begin
                next = ground ? DL : FL;
            end
            DR: begin
                next = ground ? DR : FR;
            end
            SPLAT: next = SPLAT;
        endcase
    end

    always @(posedge clk, posedge areset) begin
        if (areset) state <= L;
        else begin
            state <= next;
            if (state == FL | state == FR) begin
            	count <= count + 1;
        	end
        	else begin
            	count <= 0;
        	end
        end
    end

    assign walk_left = (state == L);
    assign walk_right = (state == R);
    assign aaah = (state == FL | state == FR);
    assign digging = (state == DL | state == DR);

endmodule
