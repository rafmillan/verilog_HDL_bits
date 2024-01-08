/*
Circuit B can be described by the following simulation waveform:

X   ______------______------

Y   ____________------------

Z   ------____________------
*/

module top_module ( input x, input y, output z );
    
    assign z = x == y;

endmodule
