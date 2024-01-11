/*
The game Lemmings involves critters with fairly simple brains.
So simple that we are going to model it using a finite state
machine.

In the Lemmings' 2D world, Lemmings can be in one of two states:
walking left or walking right. It will switch directions if it
hits an obstacle. In particular, if a Lemming is bumped on the
left, it will walk right. If it's bumped on the right, it will
walk left. If it's bumped on both sides at the same time, it will
still switch directions.

Implement a Moore state machine with two states, two inputs,
and one output that models this behaviour.
*/

module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right); //  

    parameter L=0, R=1;
    reg state, next;

    always @(*) begin
        case (state)
            L: next = bump_left ? R : L;
            R: next = bump_right ? L : R;
        endcase
    end

    always @(posedge clk, posedge areset) begin
        if (areset) state <= L;
        else state <= next;
    end

    assign walk_left = (state == L);
    assign walk_right = (state == R);

endmodule
