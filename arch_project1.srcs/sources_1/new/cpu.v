`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2026 08:34:44 AM
// Design Name: 
// Module Name: cpu
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



module cpu(
    input clk,
    input rst,
    input [3:0] ssdSel,
    output reg [12:0] out
);
    reg active; // ANDed with clk to KILL the CPU in case of ECALL, EBREAK, PAUSE, FENCE, and FENCE.TSO 
    
   
    reg [31:0] PCin;
    wire [31:0] PCout;
 
    register PC(
        .in(PCin),
        .load(1'b1),
        .clk(clk & active),
        .rst(rst),
        .out(PCout)
    );
    wire [31:0] instruction;
    instruction_memory IM(
        .addr(PCout[7:2]),
        .data_out(instruction)
    );
    wire Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
    wire [1:0] ALUOp;
    control_unit CU(
        .instruction(instruction),
        .Branch(Branch),
        .MemRead(MemRead),
        .MemtoReg(MemtoReg),
        .ALUOp(ALUOp),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite) 
    );
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [4:0] rd;
    assign rs1 = instruction[19:15];
    assign rs2 = instruction[24:20];
    assign rd = instruction[11:7];
    reg [31:0] reg_write_data;
    wire [31:0] read_data1;
    wire [31:0] read_data2;
    register_file RF (
        .read_add1(rs1),
        .read_add2(rs2),
        .write_add(rd),
        .write_data(reg_write_data),
        .reg_write(RegWrite),
        .clk(clk & active),
        .rst(rst),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );
    wire [31:0] immediate;
    ImmGen IMMGEN(
        .inst(instruction), 
        .gen_out(immediate)
    );
    wire [3:0] ALU_select;
    ALU_control_unit ALUCU(
        .ALUOp(ALUOp),
        .instruction(instruction),
        .ALU_select(ALU_select)
    );
    wire [31:0] ALU_out;
    wire Z, V, C, S;
    ALU ALU_INSTANCE(
        .a(read_data1),
        .b(ALUSrc ? immediate : read_data2),
        .alu_control(ALU_select),
        .result(ALU_out),
        .Z(Z),
        .S(S),
        .V(V),
        .C(C)
    );
    wire [31:0] DM_out;
    DataMem DM(
        .clk(clk & active),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .addr(ALU_out[7:0]), 
        .data_in(read_data2),
        .func3(instruction[14:12]),
        .data_out(DM_out)
    );
    
    wire [31:0] PC_IMM;
    wire [31:0] PC_NEXT;
    always @ * begin
        if(MemtoReg)
            reg_write_data = DM_out;
        else if(instruction[6:2] == 5'b11011 || instruction[6:2] == 5'b11001) // JAL & JALR
            reg_write_data = PC_NEXT;
        else if(instruction[6:2] == 5'b00101) // AUIPC
            reg_write_data = PC_IMM;
        else if(instruction[6:2] == 5'b01101) // LUI
            reg_write_data = immediate;
        else
            reg_write_data = ALU_out;
    end
    
    
    
    wire [31:0] shifted_immediate;
    nbitshiftleft1 SHIFTBY1(
        .in(immediate),
        .out(shifted_immediate)
    );
    
    rca PC_IMM_ADDER(
        .cin(1'b0),
        .a(PCout),
        .b(instruction[6:2] != 5'b00101 ? shifted_immediate : immediate), // AUIPC does not shift its immediate
        .sum(PC_IMM)
    );
    
    rca PC_ADDER(
        .cin(1'b0),
        .a(PCout),
        .b(32'd4),
        .sum(PC_NEXT)
    );
    //assign PCin = Branch & Z ? PC_IMM : PC_NEXT;
    
    always @ * begin
        if(instruction[6:2] == 5'b11011) // JAL
            PCin = PC_IMM;
        else if(instruction[6:2] == 5'b11001) // JALR
            PCin = ALU_out & 32'hFFFFFFFE; // Ensures 2-byte Alignemnt to support Compressed instructions later
        else if(Branch) begin // Branch Instructions
            case(instruction[14:12])
            3'b000: PCin = Z ? PC_IMM : PC_NEXT;  // BEQ
            3'b001: PCin = ~Z ? PC_IMM : PC_NEXT; // BNE 
            3'b100: PCin = (S != V) ? PC_IMM : PC_NEXT; // BLT
            3'b101: PCin = (S == V) ? PC_IMM : PC_NEXT; // BGE
            3'b110: PCin = ~C ? PC_IMM : PC_NEXT;   // BLTU
            3'b111: PCin = C ? PC_IMM : PC_NEXT;    // BGEU
            default: PCin = PC_NEXT;
            endcase
        end
        else
            PCin = PC_NEXT; // Normal Flow
    end
    
    
    always @ * begin 
        if(instruction[6:2] == 5'b00011 || instruction[6:2] == 5'b11100)
            active = 1'b0;
    end
    always @ (posedge rst) begin
        active <= 1'b1;
    end
    
    
   always @ * begin
        case(ssdSel)
            4'b0000: out = PCout[12:0];
            4'b0001: out = PC_NEXT[12:0];
            4'b0010: out = PC_IMM[12:0];
            4'b0011: out = PCin[12:0];
            4'b0100: out = read_data1[12:0];
            4'b0101: out = read_data2[12:0];
            4'b0110: out = reg_write_data[12:0];
            4'b0111: out = immediate[12:0];
            4'b1000: out = shifted_immediate[12:0];
            4'b1001: out = ALUSrc ? immediate[12:0] : read_data2[12:0];
            4'b1010: out = ALU_out[12:0];
            4'b1011: out = DM_out[12:0];
            default: out = 13'd0;
        endcase
    end


endmodule
