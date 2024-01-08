/*
See mt2015_q4a and mt2015_q4b for the submodules used here.
*/

module mod_a (input x, input y, output z);
    
    assign z = (x ^ y) & x;

endmodule

module mod_b ( input x, input y, output z );
    
    assign z = x == y;

endmodule

module top_module (input x, input y, output z);
    
    wire z0, z1, z2, z3;
    
    mod_a ia1 (x, y, z0);
    mod_b ib1 (x, y, z1);
    mod_a ia2 (x, y, z2);
    mod_b ib2 (x, y, z3);
    
    assign z = (z0 | z1) ^ (z2 & z3);

endmodule


