`timescale 10ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.01.2020 17:45:41
// Design Name: 
// Module Name: test_ControladorLED
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


module test_ControladorLED();
    reg updown_tb;
    reg move_tb;
    reg rst_tb;
    reg clk_tb;
    wire led1_tb;
    wire led2_tb;
    wire led3_tb;
    wire led4_tb;

    initial
    begin
        clk_tb = 0;
        move_tb = 0;
        updown_tb = 0;
        rst_tb = 1;

        #2
        rst_tb = 0;
        
        #50000000
        move_tb = 1;
        #20
        move_tb = 0;
      
        #50000000
        
        updown_tb = 1;
        move_tb = 1;
        #2
        move_tb = 0;
        
        #50000000;
    end
    
    always
    begin
        #0.5
        clk_tb = ~ clk_tb;
    end
   
    
    controladorLED controladorLED(updown_tb, move_tb, rst_tb, clk_tb, led1_tb, led2_tb, led3_tb, led4_tb);
    
endmodule
