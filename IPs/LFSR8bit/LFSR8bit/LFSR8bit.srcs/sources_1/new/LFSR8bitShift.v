`timescale 1ns / 1ps
/**
* Company: ALTER, TFB-UPM
* Engineer: ield
* Create Date: 20.11.2019
* Description:  8 bit up LFSR Generator. 
*               Generates a m-sequence in direct order.
*               It also generates a trigger each time the registers
*               agree with the seed. It may be used to triger the signal
*               in an osciloscope.
*               The polynomial used must be the same as in the updown IP
*               This is done for the shifting versions so that the trigger
*               only come up with a reset.
*               
*/


module LFSR8bitShift(
    input clk,
    input restart,
    input [7:0] seed,
    output seq,
    output trig
    );
    
    //This will always be the seed at imput at the normal LFSR and the trigger
    //must plug when this is the seed. So that in the shifted LFSR the frequency
    //of the trigger is much smaller
    localparam[7:0] basicSeed = 8'b11111111;
    
    reg [7:0] registro;
    wire rd1, rd2, rd3;
    reg t;
    

   //direct
   
    assign rd1 = (~(registro[7] & registro[6])) & (registro[7] | registro[6]);
    assign rd2 = (~(rd1 & registro[1])) & (rd1 | registro[1]);
    assign rd3 = (~(rd2 & registro[0])) & (rd2 | registro[0]);
    
    assign trig = t;
    assign seq = registro[7];
    
    always @(posedge clk) begin
        if (restart) begin
          registro = seed;
          if(registro == basicSeed) begin
            t = 1;
          end
        end
        else begin
            registro = {registro[6:0], rd3};
            t = 0;
        end
    end
    
endmodule
