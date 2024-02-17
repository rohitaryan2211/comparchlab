`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.02.2024 19:11:58
// Design Name: 
// Module Name: comparator_3bit
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


//Gate Level Modelling

module comp3b_gate(
    a,
    b,
    EQ,
    GR,
    LS
    );
    
    input [2:0] a;
    input [2:0] b;
    output EQ;
    output GR;
    output LS;
    
    buf(a2, a[2]);
    buf(a1, a[1]);
    buf(a0, a[0]);
    
    buf(b2, b[2]);
    buf(b1, b[1]);
    buf(b0, b[0]);
    
    not(a2d, a2);
    not(a1d, a1);
    not(a0d, a0);
    
    not(b2d, b2);
    not(b1d, b1);
    not(b0d, b0);   
    
    xnor(u0, a0, b0);
    xnor(u1, a1, b1);
    xnor(u2, a2, b2);
       
    and(u3, a2, b2d);
    and(u4, a1, b1d);
    and(u5, a0, b0d);
    
    and(u6, a2d, b2);
    and(u7, a1d, b1);
    and(u8, a0d, b0);
    
    and(EQ, u0, u1, u2);
    
    and(u9, u2, u4);
    and(u10, u2, u1, u5);
    or(GR, u3, u9, u10);
    
    and(u11, u2, u7);
    and(u12, u2, u1, u8);
    or(LS, u6, u11, u12);
    
endmodule


//Data Flow Modelling

module comp3b_data(
    a,
    b,
    EQ,
    GR,
    LS
);

    input [2:0] a;
    input [2:0] b;
    output EQ;
    output GR;
    output LS;
    
    assign a0 = a[0];
    assign a1 = a[1];
    assign a2 = a[2];
    
    assign b0 = b[0];
    assign b1 = b[1];
    assign b2 = b[2];
    
    assign a0d = ~a[0];
    assign a1d = ~a[1];
    assign a2d = ~a[2];
    
    assign b0d = ~b[0];
    assign b1d = ~b[1];
    assign b2d = ~b[2];
    
    assign EQ = ((a2 & b2) | (a2d & b2d)) & ((a1 & b1) | (a1d & b1d)) & ((a0&b0) | (a0d & b0d));
    assign GR = (a2 & b2d) | ((a1 & b1d) & ((a2 & b2)|(a2d & b2d))) | ((a0 & b0d) & ((a1 & b1) | (a1d & b1d)) & ((a2 & b2) | (a2d & b2d)));
    assign LS = (a2d & b2) | ((a1d & b1) & ((a2 & b2)|(a2d & b2d))) | ((a0d & b0) & ((a1 & b1) | (a1d & b1d)) & ((a2 & b2) | (a2d & b2d)));
    
endmodule


//Behavioral Modelling

module comp3b_behav(
    a,
    b,
    EQ,
    GR,
    LS
);

    input [2:0] a;
    input [2:0] b;
    output reg EQ;
    output reg GR;
    output reg LS;
    
    always @(a, b) begin
        // Equality check
        assign EQ = (a == b);

        // Greater than check
        assign GR = (a > b);

        // Less than check
        assign LS = (a < b);
    end
    
endmodule
