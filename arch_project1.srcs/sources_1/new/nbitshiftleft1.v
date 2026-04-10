`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/17/2026 10:04:22 AM
// Design Name: 
// Module Name: nbitshiftleft1
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


module nbitshiftleft1 #(N = 32)(
    input [N-1:0] in,
    output [N-1:0] out
);
    assign out = {in[N-2:0], 1'b0};
endmodule
