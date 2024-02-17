`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.02.2024 19:00:58
// Design Name: 
// Module Name: convert_excess3
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module convert_excess3(
    in,
    out
    );
    
    input [3:0] in;
    output [3:0] out;
    
    buf(a, in[3]);
    buf(b, in[2]);
    buf(c, in[1]);
    buf(d, in[0]);
    
    not(ad, a);
    not(bd, b);
    not(cd, c);
    not(dd, d);
    
    buf(p, a);
    
    and(u1, a, d);
    and(u2, a, c);
    and(u3, a, b);
    and(u4, b, c, d);
    or(q, u1, u2, u3, u4);
    
    and(u5, a,cd, dd);
    and(u6, ad, cd, d);
    and(u7, ad, c, dd);
    and(u8, a, c, d);
    or(r, u5, u6, u7, u8);
    
    not(s, d);
    
    buf(out[3], p);
    buf(out[2], q);
    buf(out[1], r);
    buf(out[0], s);
    
endmodule
