`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2026 09:32:50 PM
// Design Name: 
// Module Name: ALU_control_unit
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


module ALU_control_unit(
    input [1:0] ALUOp,
    input [31:0] instruction,
    output reg [3:0] ALU_select
);
    always @ * begin
        if (ALUOp == 2'b00)
            ALU_select = 4'b0010;
        else if (ALUOp == 2'b01)
            ALU_select = 4'b0110;
        else begin
            case(instruction[14:12])
                3'b000: begin
                    if (instruction[30])
                        ALU_select = 4'b0110; // SUB
                    else
                        ALU_select = 4'b0010; // ADD
                end
                3'b001: ALU_select = 4'b0100; // SLL
                3'b010: ALU_select = 4'b0111; // SLT
                3'b011: ALU_select = 4'b1000; // SLTU
                3'b100: ALU_select = 4'b0011; // XOR 
                3'b101: begin
                    if (instruction[30])
                        ALU_select = 4'b1001; // SRA
                    else
                        ALU_select = 4'b0101; // SRL
                end
                3'b110: ALU_select = 4'b0001; // OR
                3'b111: ALU_select = 4'b0000; // AND
            endcase
        end
    end
endmodule
