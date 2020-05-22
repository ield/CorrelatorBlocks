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
*               
*/


module LFSR8bitUp(
    input clk,
    input restart,
    input [7:0] seed,
    output seq,
    output trig_1
    );
    
    //This will always be the seed at imput at the normal LFSR and the trigger
    //must plug when this is the seed. So that in the shifted LFSR the frequency
    //of the trigger is much smaller
    localparam[7:0] basicSeed_1 = 8'b01111111;//synchronize some components
    localparam[7:0] basicSeed = 8'b11111111;//synchronize other components
    
    reg [7:0] registro;
    wire rd1, rd2, rd3;
    reg t, t_1;
    

   //direct
   
    assign rd1 = (~(registro[7] & registro[6])) & (registro[7] | registro[6]);
    assign rd2 = (~(rd1 & registro[1])) & (rd1 | registro[1]);
    assign rd3 = (~(rd2 & registro[0])) & (rd2 | registro[0]);
    
    assign trig_1 = t_1;
    assign seq = registro[7];
    
    always @(posedge clk) begin
        if (restart) begin
          registro = seed;
        end
        else begin
            registro = {registro[6:0], rd3};
        end
    end
    
    always @(posedge clk) begin
        
        if(registro == basicSeed_1)begin
            t_1 = 1;      
        end
        else begin
            t_1 = 0;
        end
    
    end
    
endmodule
