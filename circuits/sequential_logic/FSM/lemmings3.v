/*
See also: Lemmings1 and Lemmings2.

In addition to walking and falling, Lemmings can sometimes be
told to do useful things, like dig (it starts digging when dig=1).
A Lemming can dig if it is currently walking on ground (ground=1
and not falling), and will continue digging until it reaches the
other side (ground=0). At that point, since there is no ground,
it will fall (aaah!), then continue walking in its original
direction once it hits ground again. As with falling, being
bumped while digging has no effect, and being told to dig when
falling or when there is no ground is ignored.

(In other words, a walking Lemming can fall, dig, or switch
directions. If more than one of these conditions are satisfied,
fall has higher precedence than dig, which has higher precedence
than switching directions.)

Extend your finite state machine to model this behaviour.
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
    
    parameter L=0, R=1, FL=2, FR=3, DL=4, DR=5;
    reg [2:0] state, next;

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
            FL: next = ground ? L : FL;
            FR: next = ground ? R : FR;
            DL: begin
                next = ground ? DL : FL;
            end
            DR: begin
                next = ground ? DR : FR;
            end
        endcase
    end

    always @(posedge clk, posedge areset) begin
        if (areset) state <= L;
        else state <= next;
    end

    assign walk_left = (state == L);
    assign walk_right = (state == R);
    assign aaah = (state == FL | state == FR);
    assign digging = (state == DL | state == DR);

endmodule
