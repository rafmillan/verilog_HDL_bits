/*
Create a set of counters suitable for use as a 12-hour clock
(with am/pm indicator). Your counters are clocked by a fast-running clk,
with a pulse on ena whenever your clock should increment
(i.e., once per second).

reset resets the clock to 12:00 AM. pm is 0 for AM and 1 for PM.
hh, mm, and ss are two BCD (Binary-Coded Decimal) digits each for
hours (01-12), minutes (00-59), and seconds (00-59).
Reset has higher priority than enable, and can occur even when not enabled.

The following timing diagram shows the rollover behaviour from
11:59:59 AM to 12:00:00 PM and the synchronous reset and enable behaviour.
*/

module dec_counter (
    input clk,
    input reset,
    input ena,
    input load,
    input [3:0] d,
    output [3:0] q);
    
    always @ (posedge clk) begin
        if (reset || (q == 9 & ena)) q <= 4'b0;
        else if (load) q <= d;
        else if (ena) q += 1'b1;
    end

endmodule

module sixty_count (
    input clk,
    input reset,
    input ena,
    output cout,
    output [7:0] q);
    
    wire enab;
    assign enab = ena & (q[3:0] == 4'h9);
    assign cout = ena & (q == {4'h5, 4'h9});
    
    dec_counter counter_ones (clk, reset | cout, ena, 1'b0, 4'b0, q[3:0]);
    dec_counter counter_tens (clk, reset | cout, enab, 1'b0, 4'b0, q[7:4]);
    
endmodule

module twelve_count (
    input clk,
    input reset,
    input ena,
    output cout,
    output [7:0] q);
    
    wire enab;
    assign enab = ena & (q[3:0] == 4'h9);
    assign cout = ena & (q == {4'h1, 4'h2});
    
    wire [7:0] rst;
    assign rst[3:0] = reset ? 4'h2 : 4'h1;
    assign rst[7:4] = reset ? 4'h1 : 4'h0;

    dec_counter counter_ones (clk, 1'b0, ena, reset | cout, rst[3:0], q[3:0]);
    dec_counter counter_tens (clk, 1'b0, enab, reset | cout, rst[7:4], q[7:4]);
    
endmodule

module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
    
    wire [2:0] enable;
    sixty_count seconds (clk, reset, ena, enable[0], ss);
    sixty_count minutes (clk, reset, ena & enable[0], enable[1], mm);
    twelve_count hours (clk, reset, ena & enable[1], enable[2], hh);
    
    always @ (posedge clk) begin
        if (reset) pm <= 0;
        else if ((ss == 8'h59) & (mm == 8'h59) & (hh == 8'h11)) pm <= ~pm;
    end

endmodule
