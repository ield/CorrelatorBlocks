`timescale 1ns / 1ps
/**
* Company: ALTER, TFB-UPM
* Engineer: ield
* Create Date: 10.01.2020
* Description:  Detects when tjere i an edge.
*               After the edge, it generates a pulse which lasts 1 clk period.
*/


module DetectorPulsos(
    input clk,
    input butt,
    output pulse
    );
    reg pulso;
    reg isUp;

    assign pulse = pulso;

    
    always @(posedge clk) begin
        if(butt == 0) begin
            pulso = 0;
            isUp = 0;
        end
        else if (butt == 1 & isUp == 0)begin
            pulso = 1;
            isUp = 1;
        end
        else begin
            pulso = 0;
        end
            
    end
    
endmodule
