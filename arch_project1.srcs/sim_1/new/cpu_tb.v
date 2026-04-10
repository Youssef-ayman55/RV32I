`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2026 09:31:41 AM
// Design Name: 
// Module Name: cpu_tb
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


module cpu_tb();
    localparam PERIOD = 10;
    reg clk;
    reg rst;
    reg [3:0] ssdSel;
    wire [12:0] out;
    cpu CPU_INST(
        .clk(clk),
        .rst(rst),
        .out(out),
        .ssdSel(ssdSel)
    );
    
    initial begin
        clk = 1'b0;
        forever begin
            #(PERIOD / 2);
            clk <= ~clk;
        end
    end
    initial begin 
        ssdSel = 4'b0110;
        rst = 1'b0;
        #(2 * PERIOD);
        rst = 1'b1;
        #(2 * PERIOD);
        rst = 1'b0;
        #(24 * PERIOD);
        $finish;
    end

endmodule
