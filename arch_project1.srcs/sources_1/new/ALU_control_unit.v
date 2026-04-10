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
                        ALU_select = 4'b0110;
                    else
                        ALU_select = 4'b0010;
                end
                3'b111: ALU_select = 4'b0000;
                3'b110: ALU_select = 4'b0001;
                default: ALU_select = 4'b0000;
            endcase
        end
    end
endmodule
