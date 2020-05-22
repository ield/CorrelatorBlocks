`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.11.2019 17:01:35
// Design Name: 
// Module Name: debouncer
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


module debouncer(
    input clk,
    input butt,
    output pulse
    );
    reg pulso;
    reg [24:0] count = 0;
    assign pulse = pulso;
    
    assign isUp = count[24];
    
    always @(posedge clk) begin
        if(butt == 0) begin
            pulso = 0;
        end
        else begin
            count <= count + 1;
            if(count == 2000) begin
                pulso = 1;
            end
        end
    end
endmodule
