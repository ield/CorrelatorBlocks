`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.11.2019 12:45:47
// Design Name: 
// Module Name: test_clockmux
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


module test_clockmux();
    reg clk_1_tb;
    reg clk_2_tb;
    reg clk_3_tb;
    reg[1:0] sele_tb;
    wire clkOut_tb;
    
    
    
    //TestBench muestra la señal en directa. Cuando se pulsa el rst reinicia
    initial
    begin
        clk_1_tb = 0;
        clk_2_tb = 0;
        clk_3_tb = 0;
        
        sele_tb = 2'b00;
        #200;
        
        sele_tb = 2'b01;
        #200;
        
        sele_tb = 2'b10;
        #200;

    end
     //Aqui configuramos los clocks a diferentes periodos
    always
    begin
        #10;
        clk_1_tb = ~ clk_1_tb;
    end
    
        always
    begin
        #20;
        clk_2_tb = ~ clk_2_tb;
    end
    
        always
    begin
        #40;
        clk_3_tb = ~ clk_3_tb;
    end
    
    ClockMux ClockMux(clk_1_tb, clk_2_tb, clk_3_tb, sele_tb, clkOut_tb);
endmodule
