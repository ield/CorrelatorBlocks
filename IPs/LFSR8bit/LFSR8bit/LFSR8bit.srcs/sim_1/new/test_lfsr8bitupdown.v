`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.10.2019 16:50:37
// Design Name: 
// Module Name: test_circuito_simple
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


module test_lfsr8bitupdown();
 
    reg clk_tb;
    reg rst_tb;
    reg updown_tb;
    reg[7:0] seed_tb;
    wire[7:0] outReg_tb;
    
    
    
    //TestBench muestra la señal en directa. Cuando se pulsa el rst reinicia
    initial
    begin
        clk_tb = 0;
        seed_tb = 8'b11111111;
        rst_tb = 1;
        updown_tb = 0;
        #15;
        
        rst_tb = 0;
        #500;
        
        updown_tb = 1;

        #100;
    end
    
    always
    begin
        #10;
        clk_tb = ~ clk_tb;
    end
    
    LFSR8bitUpDown LFSR8bitUpDown(clk_tb, rst_tb, updown_tb, seed_tb, outReg_tb);
    
endmodule
