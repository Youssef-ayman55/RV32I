`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2026 07:37:25 AM
// Design Name: 
// Module Name: alu
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

module full_adder(
    input a,
    input b,
    input cin,
    output sum,
    output cout
);

    assign {cout, sum} = a + b + cin;

endmodule

module rca  #(parameter n = 8)(
    input cin,
    input [n - 1:0] a,
    input [n - 1:0] b,
    output [n - 1:0] sum,
    output cout
);

    wire [n:0] c;
    assign cout = c[n];
    assign c[0] = cin;
    genvar i;
    generate
        for (i = 0; i < n; i = i + 1) begin : gen_fa 
            full_adder fa_inst (
                .a(a[i]),
                .b(b[i]),
                .cin(c[i]),
                .sum(sum[i]),
                .cout(c[i+1])
            );
        end
    endgenerate
endmodule



module mux16x1 #(parameter N = 32) (
    input [N-1:0] x0,
    input [N-1:0] x1,
    input [N-1:0] x2,
    input [N-1:0] x3,
    input [N-1:0] x4,
    input [N-1:0] x5,
    input [N-1:0] x6,
    input [N-1:0] x7,
    input [N-1:0] x8,
    input [N-1:0] x9,
    input [N-1:0] x10,
    input [N-1:0] x11,
    input [N-1:0] x12,
    input [N-1:0] x13,
    input [N-1:0] x14,
    input [N-1:0] x15,
    input [3:0] s,
    output reg [N-1:0] out
);
    always @ * begin
        case(s)
            4'b0000: out = x0;
            4'b0001: out = x1;
            4'b0010: out = x2;
            4'b0011: out = x3;
            4'b0100: out = x4;
            4'b0101: out = x5;
            4'b0110: out = x6;
            4'b0111: out = x7;
            4'b1000: out = x8;
            4'b1001: out = x9;
            4'b1010: out = x10;
            4'b1011: out = x11;
            4'b1100: out = x12;
            4'b1101: out = x13;
            4'b1110: out = x14;
            4'b1111: out = x15;
        endcase
    end
endmodule



module ALU #(parameter N = 32)(
    input [N-1:0] a,
    input [N-1:0] b,
    input [3:0] alu_control,
    output [N-1:0] result,
    output reg V, // overflow flag for ADD and SUB only
    output reg C,     // carry flag for ADD and SUB only (Borrow = ~Carry)
    output Z,     // zero flag
    output S      // sign flag
);
    wire [N-1:0] rca_out;
    wire rca_cout;
    rca #(N) rca_inst (
        .a(a),
        .b(alu_control[2] ? ~b : b),
        .sum(rca_out),
        .cin(alu_control[2]),
        .cout(rca_cout)
    );
    
    mux16x1 #(N) alu_mux(
        .x0(a & b), // AND
        .x1(a | b), // OR
        .x2(rca_out), // ADD
        .x3(a ^ b), // XOR
        .x4(a << b[4:0]), // SLL
        .x5($unsigned(a) >> b[4:0]), // SRL
        .x6(rca_out), // SUB
        .x7($signed(a) < $signed(b) ? 32'd1 : 32'd0), // SLT 
        .x8(a < b ? 32'd1 : 32'd0), // SLTU
        .x9($signed(a) >>> b[4:0]), // SRA
        .x10(0), // empty for now 
        .x11(0), // empty for now 
        .x12(0), // empty for now 
        .x13(0), // empty for now 
        .x14(0), // empty for now 
        .x15(0), // empty for now 
        .s(alu_control),
        .out(result)
    );
    assign S = result[31];
    assign Z = (result == 32'd0);
    always @ * begin
        if(alu_control == 4'd2) begin
            V = (S & ~a[31] & ~b[31]) | (~S & a[31] & b[31]);
            C = rca_cout;
        end
        else if(alu_control == 4'd6) begin
            V = (S & ~a[31] & b[31]) | (~S & a[31] & ~b[31]);
            C = rca_cout;
        end
        else begin
            V = 0;
            C = 0;
        end
    end
endmodule
