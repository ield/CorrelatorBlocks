`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: FPGA Blog
// Engineer: Will Green
// 
// Retrieved from https://timetoexplore.net/blog/arty-fpga-verilog-02
//////////////////////////////////////////////////////////////////////////////////


module pwm(
    input clk,
    input [7:0] i_duty,
    output reg o_state
    );

    reg [7:0] counter = 0;

    always @ (posedge clk)
    begin
        counter <= counter + 1;
        o_state <= (counter < i_duty);
    end
endmodule
