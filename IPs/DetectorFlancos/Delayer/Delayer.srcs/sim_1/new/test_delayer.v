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


module test_circuito_simple();
 
    reg clk_tb;
    reg signal_tb;
    wire pulse_tb;
    
    
    initial
    begin
        clk_tb = 1;
        signal_tb = 0;
        
        #10
        signal_tb = 1;
        #8;       
        signal_tb = 0;
        
        #10
        signal_tb = 1;
        #8;       
        signal_tb = 0;
        
        
        #500;
        signal_tb = 1;

    end
    
    always
    begin
        #1;
        clk_tb = ~ clk_tb;
    end
    
    
    delayer delayer(clk_tb, signal_tb, pulse_tb);
    
endmodule
