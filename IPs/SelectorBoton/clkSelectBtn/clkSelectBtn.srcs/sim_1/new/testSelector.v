`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.01.2020 17:18:55
// Design Name: 
// Module Name: testSelector
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


module testSelector();

    reg btn1_tb, btn2_tb, btn3_tb;
    reg clk_tb;
    wire[1:0] btn_tb;
    
    initial
    begin
        clk_tb = 0;
        btn1_tb = 0;
        btn2_tb = 0;
        btn3_tb = 0;
        
        #10
        btn1_tb = 1;
        #10
        btn1_tb = 0;
        #50
        

        btn2_tb = 1;
        #10
        btn2_tb = 0;
        #50
        

        btn3_tb = 1;
        #10
        btn3_tb = 0;
        #50;
    end
    
    always
    begin
        #1;
        clk_tb = ~ clk_tb;
    end
    
    selector selector(btn1_tb, btn2_tb, btn3_tb, clk_tb, btn_tb);
endmodule
