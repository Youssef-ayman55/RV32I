`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2026 08:09:34 AM
// Design Name: 
// Module Name: rca
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


module rca  #(parameter n = 32)(
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
