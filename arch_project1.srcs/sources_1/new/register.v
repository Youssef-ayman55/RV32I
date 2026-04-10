`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/17/2026 08:39:42 AM
// Design Name: 
// Module Name: register
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

module DFlipFlop(
    input clk, 
    input rst, 
    input D, 
    output reg Q
);
    always @ (posedge clk or posedge rst)
    if (rst) begin
        Q <= 1'b0;
    end else begin
        Q <= D;
    end
endmodule

module register #(parameter N = 32)(
    input [N-1:0] in,
    input load,
    input clk,
    input rst,
    output [N-1:0] out    
);

genvar i;
wire [N-1:0] Ds;
generate
    for (i = 0; i < N; i = i + 1) begin : flipflop_instance
        mux2x1 mux(
            .a(out[i]),
            .b(in[i]),
            .s(load),
            .out(Ds[i])
        );
        DFlipFlop flipflop(
            .clk(clk),
            .rst(rst),
            .D(Ds[i]),
            .Q(out[i])
        );
    end
endgenerate

endmodule
