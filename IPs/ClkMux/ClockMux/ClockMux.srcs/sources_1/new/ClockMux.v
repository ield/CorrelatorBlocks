`timescale 1ns / 1ps
/**
* Company: ALTER, TFB-UPM
* Engineer: ield
* Create Date: 21.11.2019
* Description:  is a mux which selects among 3 different clocks
*/
module ClockMux(

    input clk_1,
    input clk_2,
    input clk_3,
    input[1:0] sele,
    output clkOut
    );
    
    reg clk;
    
    assign clkOut = clk;
    
    always@(sele, clk_1, clk_2, clk_3) begin
        
        if(sele == 2'b00) begin
            clk = clk_1;
        end
        else if(sele == 2'b01) begin
            clk = clk_2;
        end
        else if(sele == 2'b10) begin
            clk = clk_3;
        end
            
    end

        
endmodule