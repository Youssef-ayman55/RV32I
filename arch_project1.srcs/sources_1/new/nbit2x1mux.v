`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/17/2026 09:48:12 AM
// Design Name: 
// Module Name: nbit2x1mux
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
module mux2x1 (
    input a,
    input b,
    input s,
    output out
);
    assign out = s ? b : a;
endmodule

module nbit2x1mux #(N=1)(
    input [N-1:0] a,
    input [N-1:0] b,
    input s,
    output [N-1:0] out
);
genvar i;

generate 
     for (i = 0; i < N; i = i + 1) begin : flipflop_instance
        mux2x1 mux(
            .a(a[i]),
            .b(b[i]),
            .s(s),
            .out(out[i])
        );
     end
endgenerate 
endmodule
