`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.11.2019 10:24:54
// Design Name: 
// Module Name: LFSR8bitUpDown
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


module LFSR8bitUpDown(
    input clk,
    input restart,
    input updown,
    input [7:0] seed,
    output [7:0] outReg
    );
    
    reg [7:0] registro;
    wire rd1, rd2, rd3, ri1, ri2, ri3;
    reg xRegistro;
    
    
   //direct
    assign rd1 = (~(registro[7] & registro[6])) & (registro[7] | registro[6]);
    assign rd2 = (~(rd1 & registro[1])) & (rd1 | registro[1]);
    assign rd3 = (~(rd2 & registro[0])) & (rd2 | registro[0]);
    
    //reverse
    assign ri1 = (~(registro[0] & registro[1])) & (registro[0] | registro[1]);
    assign ri2 = (~(ri1 & registro[2])) & (ri1 | registro[2]);
    assign ri3 = (~(ri2 & registro[7])) & (ri2 | registro[7]);
    
    assign outReg = registro;
  
    always @(posedge clk) begin
        if (restart) begin
          registro = seed;
        end
        else if(updown == 0) begin
            registro = {registro[6:0], xRegistro};
          
        end
        else if(updown == 1) begin
            registro = {xRegistro, registro[7:1]};
        end
        
    end
    
    //Multiplexor 2:1 1bit
    always @(updown, rd3, ri3) begin
        if (updown == 0)
            xRegistro = rd3;
        else
            xRegistro = ri3;
    end
endmodule
