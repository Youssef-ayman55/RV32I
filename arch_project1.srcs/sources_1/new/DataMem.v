`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2026 09:09:00 AM
// Design Name: 
// Module Name: DataMem
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


module DataMem(input clk, input MemRead, input MemWrite,
input [7:0] addr, input [31:0] data_in, input[2:0] func3, output reg [31:0] data_out);
reg [7:0] mem [0:255];
    initial begin
        mem[0]=8'd255;
        mem[1]=8'd255;
        mem[2]=8'd255;
        mem[3]=8'd127;
        mem[4]=8'd3;
        mem[5]=8'd0;
        mem[6]=8'd0;
        mem[7]=8'd0;
        mem[8]=8'd10;
        mem[9]=8'd0;
        mem[10]=8'd0;
        mem[11]=8'd0;
       
    end
    always @ (posedge clk) begin
            if (MemWrite) begin
                if (func3[1:0] == 2'b00)
                    mem[addr] = data_in[7:0];
                else if (func3[1:0] == 2'b01) begin
                    mem[addr] = data_in[7:0];
                    mem[addr + 1] = data_in[15:8];
                end 
                else begin
                    mem[addr] = data_in[7:0];
                    mem[addr + 1] = data_in[15:8];
                    mem[addr + 2] = data_in[23:16];
                    mem[addr + 3] = data_in[31:24];
                end
            end
        end
    reg extend;
    always @ * begin
        if (MemRead) begin
            if (func3[1:0] == 2'b00) begin
               extend = (func3[2] == 1'b0) ? 1'b0 : mem[addr][7];
               data_out = {{24{extend}}, mem[addr]};              
            end
            else if (func3[1:0] == 2'b01) begin
               extend = (func3[2] == 1'b0) ? 1'b0 : mem[addr + 1][7];
               data_out = {{16{extend}}, mem[addr + 1], mem[addr]};     
            end
            else begin
               extend = 1'b0;
               data_out = {mem[addr + 3], mem[addr + 2], mem[addr + 1], mem[addr]};  
            end   
        end
        else
            data_out = 32'd0;
    end
    
    
endmodule
