`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.01.2020 16:21:44
// Design Name: 
// Module Name: testControladorRGB
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


module testControladorRGB();
    reg[1:0] clk1_tb;
    reg rst_tb;
    reg clk_tb;
    wire rgb0r_tb;
    wire rgb0g_tb;
    wire rgb0b_tb;
    wire rgb1r_tb;
    wire rgb1g_tb;
    wire rgb1b_tb;
    
    
    initial
    begin
        clk_tb = 0;
        clk1_tb = 2'b01;
        rst_tb = 1;
        
        #10
        rst_tb = 0;
        
        #500;
        
        clk1_tb = 2'b10;
        #500;
        
        clk1_tb = 2'b00;

        #500;
        rst_tb = 1;

       
    end
    
    always
    begin
        #10;
        clk_tb = ~ clk_tb;
    end
    ControladorRGB ControladorRGB(clk1_tb, rst_tb, clk_tb, rgb0r_tb, rgb0g_tb, rgb0b_tb, rgb1r_tb, rgb1g_tb, rgb1b_tb);

endmodule
