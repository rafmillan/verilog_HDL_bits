module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4);

    parameter A=1, B=2, C=3, D=4, E=5, F=6;
    reg [6:1] next;
    
    assign next[A] = w & (y[A] | y[D]);
    assign next[B] = ~w & y[A];
    assign next[C] = ~w & (y[B] | y[F]);
    assign next[D] = w & (y[B] | y[C] | y[E] | y[F]);
    assign next[E] = ~w & (y[C] | y[E]);
    assign next[F] = ~w & y[F];
    
    assign Y2 = next[B];
    assign Y4 = next[D];
    
endmodule
