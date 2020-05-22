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


module test_lfsr8bitshift();
 
    reg clk_tb;
    reg rst_tb;
    reg[7:0] seed_tb;
    wire outReg_tb;
    wire trig_tb;
    
    /*
    //TestBench muestra que cambia de directa a inversa una vez se pulsa el reset y no al reves
    initial
    begin
        clk_tb = 0;
        updown = 0;
        rst_tb = 1;
        #15;
        
        rst_tb = 0;
        #300;
        updown = 1;
        #30
        rst_tb = 1;
        #15
        rst_tb = 0;
        #100;
    end*/

    /*
    //TestBench muestra que cambia de directa a inversa
    initial
    begin
        clk_tb = 0;
        updown = 0;
        rst_tb = 1;
        #15;
        
        rst_tb = 0;
        #305;
        updown = 1;
        rst_tb = 1;
        #15
        rst_tb = 0;
        #100;
    end    */
    
    //TestBench muestra la señal en directa. Cuando se pulsa el rst reinicia
    initial
    begin
        clk_tb = 0;
        seed_tb = 8'b11111111;
        rst_tb = 1;

        #15;
        
        rst_tb = 0;
        #500;
        

        #100;
    end
    
    always
    begin
        #10;
        clk_tb = ~ clk_tb;
    end
    
    LFSR8bitShift LFSR8bitShift(clk_tb, rst_tb, seed_tb, outReg_tb, trig_tb);
    
endmodule
