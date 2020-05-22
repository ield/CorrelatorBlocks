`timescale 1ns / 1ps
/**
* Company: ALTER, TFB-UPM
* Engineer: ield
* Create Date: 06.05.2020
* Description:  Detects when tjere i an edge.
*               After the edge, it generates a pulse which lasts 1 clk period.
*               It is only useful when there is a pulse of one clock period.
*               It is used to delay the trigger of the LFSR generator for the 
*                   different components of the correlator.
*/


module delayer(
    input clk,
    input butt,
    output pulse
    );
    reg pulso;
    reg isUp;
    

    assign pulse = pulso;

    
    always @(posedge clk) begin
        if(butt == 0) begin
            isUp = 0;
            pulso = 0;
        end else if (isUp == 1) begin
            pulso = 0;        
        end else if (butt == 1)begin
            pulso = 1;
            isUp = 1;
        end
            
    end
    
endmodule
