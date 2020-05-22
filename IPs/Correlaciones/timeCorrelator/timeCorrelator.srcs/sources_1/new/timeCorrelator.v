`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ALTER/UPM
// Engineer: ield
// This blcok "multiplies" the inputs in txShift and rxAc and add them up every
//  trigger, which corresponds to a compete M-Sequence.
//  It is referred "multiplies" because it does not multiply plainly. Instead, it
//  it is always added the rxAc input. However, when the txShift is a '0', which
//  should be a '-1' it fisrt done the two's complement of the rxAc
//////////////////////////////////////////////////////////////////////////////////


module timeCorrelator(
    input clk,
    input[15:0] rxAc,
    input txShift,
    input trigger,
    output[31:0] correlation,
    output corrReady
    );
    
    localparam[7:0] MEMLENGTH = 255;

    reg[15:0] rxAc16;
    reg[15:0] prefix;
    reg[31:0] rxAc32;   
    
    reg[31:0] sum;
    reg[31:0] corr;
    
    reg[3:0] countReady;
    reg endCorrelation;
    
    assign correlation = corr;
    assign corrReady = endCorrelation;
    
    initial begin
        countReady = 0;
    end
    
    always@(posedge clk) begin    
        
        if(trigger == 1 && countReady == 0) begin // trigger sets the first value of the M-Sequence.
            corr = sum;
            sum = 0;
            countReady = 1;
            endCorrelation = 1;
        end else if(trigger == 1 && countReady <= 4) begin
            countReady = countReady + 1;
        end else begin
            endCorrelation = 0;
            countReady = 0;
        end
            
    end
    
    always@(posedge clk) begin
    
        if(txShift) begin //in the case where the correlation is with a 1
            prefix = rxAc[15];
            rxAc32 = {~prefix + 1, rxAc};//It is added a prefix so that the ca2 is coherent, not all 0
            sum = sum + rxAc32;             
        end else begin //when the corrlation is -1 it is done the ca2 of the number.
            rxAc16 = ~(rxAc - 1);//ca2
            prefix = rxAc16[15];
            rxAc32 = {~prefix + 1, rxAc16};//It is added a prefix so that the ca2 is coherent, not all 0            
            sum = sum + rxAc32;       
        end
                         
                              
    end 
        
        
                
        
        
endmodule
