`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2026 09:03:56 PM
// Design Name: 
// Module Name: control_unit
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


module control_unit(
    input [31:0] instruction,
    output reg Branch,
    output reg MemRead,
    output reg MemtoReg,
    output reg [1:0] ALUOp,
    output reg MemWrite,
    output reg ALUSrc,
    output reg RegWrite 
);

wire [4:0] condition;
assign condition = instruction[6:2];

always @ * begin
    case(condition)
        5'b00000: begin
            Branch = 1'b0;
            MemRead = 1'b1;
            MemtoReg = 1'b1;
            ALUOp = 2'b00;
            MemWrite = 1'b0;
            ALUSrc = 1'b1;
            RegWrite = 1'b1;
        end
        5'b01000: begin
            Branch = 1'b0;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            ALUOp = 2'b00;
            MemWrite = 1'b1;
            ALUSrc = 1'b1;
            RegWrite = 1'b0;
        end
        5'b01100: begin
            Branch = 1'b0;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            ALUOp = 2'b10;
            MemWrite = 1'b0;
            ALUSrc = 1'b0;
            RegWrite = 1'b1;
        end
        5'b00100: begin // I-type ALU instructions
            Branch = 1'b0;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            ALUOp = 2'b10;
            MemWrite = 1'b0;
            ALUSrc = 1'b1;
            RegWrite = 1'b1;
        end
        5'b11000: begin
            Branch = 1'b1;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            ALUOp = 2'b01;
            MemWrite = 1'b0;
            ALUSrc = 1'b0;
            RegWrite = 1'b0;
        end
        default: begin
            Branch = 1'b0;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            ALUOp = 2'b00;
            MemWrite = 1'b0;
            ALUSrc = 1'b0;
            RegWrite = 1'b0;
        end
    endcase

end


endmodule
