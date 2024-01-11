/*
See also: Lemmings1.

In addition to walking left and right, Lemmings will fall
(and presumably go "aaah!") if the ground disappears underneath
them.

In addition to walking left and right and changing direction
when bumped, when ground=0, the Lemming will fall and say "aaah!".
When the ground reappears (ground=1), the Lemming will resume
walking in the same direction as before the fall. Being bumped
while falling does not affect the walking direction, and being
bumped in the same cycle as ground disappears (but not yet falling),
or when the ground reappears while still falling, also does not
affect the walking direction.

Build a finite state machine that models this behaviour.
*/

module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
    
    parameter L=0, R=1, FL=2, FR=3;
    reg [2:0] state, next;

    always @(*) begin
        case (state)
            L: begin
                if (ground)
                    next = bump_left ? R : L;
                else
                    next = FL;
            end
            R: begin
                if (ground)
                    next = bump_right ? L : R;
                else
                    next = FR;
            end
            FL: next = ground ? L : FL;
            FR: next = ground ? R : FR;
        endcase
    end

    always @(posedge clk, posedge areset) begin
        if (areset) state <= L;
        else state <= next;
    end

    assign walk_left = (state == L);
    assign walk_right = (state == R);
    assign aaah = (state == FL | state == FR);

endmodule
