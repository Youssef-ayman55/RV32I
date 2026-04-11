`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/17/2026 10:11:17 AM
// Design Name: 
// Module Name: ImmGen
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


module ImmGen(
    input [31:0] inst, 
    output reg [31:0] gen_out
);
    wire [6:0] opcode;
    assign opcode = inst[6:0];
    always @ * begin
        case (opcode)
            7'b0100011: gen_out = {{20{inst[31]}}, inst[31:25], inst[11:7]}; // I-type instructions
            7'b1100011: gen_out = {{20{inst[31]}}, inst[31], inst[7], inst[30:25], inst[11:8]}; // Branch Instructions
            7'b1101111: gen_out = {{12{inst[31]}}, inst[31], inst[19:12], inst[20], inst[30:21]}; // JAL
            default: gen_out = {{20{inst[31]}}, inst[31:20]};
        endcase
    end
  
endmodule
