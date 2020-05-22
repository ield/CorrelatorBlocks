`timescale 1ns / 1ps
/**
* Company: ALTER, TFB-UPM
* Engineer: ield
* Create Date: 07.11.2019
* Description:  OR logic gate
*/


module OrGate(
    input a,
    input b,
    output c
    );
    
    assign c = a | b;
    
endmodule
