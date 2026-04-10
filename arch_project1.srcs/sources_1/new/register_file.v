`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2026 09:40:27 AM
// Design Name: 
// Module Name: register_file
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


module register_file #(parameter N = 32)(
    input [4:0] read_add1,
    input [4:0] read_add2,
    input [4:0] write_add,
    input [N-1:0] write_data,
    input reg_write,
    input clk,
    input rst,
    output [N-1:0] read_data1,
    output [N-1:0] read_data2
);

    reg [N-1:0] x[31:0];
    integer i;
    always @ (posedge clk or posedge rst) begin
        if (rst)
            for(i = 0; i < 32; i = i + 1)
                x[i] = 0;
        else begin
            if (reg_write & (write_add != 5'b00000))
                x[write_add] = write_data; 
        end
    end
    assign read_data1 = x[read_add1];
    assign read_data2 = x[read_add2];
    
endmodule
