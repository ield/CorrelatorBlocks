`timescale 1ns / 1ps
/**
* Company: ALTER, TFB-UPM
* Engineer: ield
* Create Date: 13.01.2020 17:08:10 
* Description:  This module sends as an output the button that has been pressed.
*               When no button is being pressed, the output is 11.
*/


module selector(
    input btn1,
    input btn2,
    input btn3,
    input clk,
    output[1:0] btn
    );
    reg[1:0] salida;
    
    assign btn = salida;
    
    always @(posedge clk) begin
        if (btn1 == 1)begin
            salida = 2'b00;
        end
        else if (btn2 == 1)begin
            salida = 2'b01;
        end
        else if (btn3 == 1)begin
            salida = 2'b10;
        end
        else begin
            salida = 2'b11;
        end
            
    end
    
endmodule
