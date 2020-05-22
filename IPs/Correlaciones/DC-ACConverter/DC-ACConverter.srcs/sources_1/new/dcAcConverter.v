`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ALTER/UPM
// Engineer: ield
// This block takes an analog input and takes away the DC component. It adds up
//  all the inputs during a M-Sequence period (between two triggers) and stores
//  the inputs in a memory. When the M-Sequence is over, it averages all the values
//  so that then it outputs all the values subtracting the DC component. As it does
//  this, new values are still entering.
//////////////////////////////////////////////////////////////////////////////////


module dcAcConverter(
    input clk,
    input[15:0] vacIn,
    input trigger,
    output[15:0] vacOut
    );
    
    localparam[15:0] MEMLENGTH = 255*4;
    
    reg[15:0] count;
    reg[31:0] sum;
    reg[31:0] average;
    

    reg[15:0] memory[MEMLENGTH-1:0];//If the sampling rate increases, the memory should increase. A large memory covers for smaller sampling rates.
    reg[15:0] vAc;
    
    reg isUp;
    /*
    There is a problem synchronizing the dcAc with the LFSRShift
    because the trigger of the dcAc must arrive at the same time 
    that the rst of the LFSR Up
    However, the clocks are different: 25MHz for the LFSSR and 100
    for the samples. The pulse of the trigger here should be addapted
    from 25MHz to 100MHz.
    */
    

    assign vacOut = vAc;
    
    // Esto parece que es una puta locura
    initial begin
        isUp = 0;
    end
    
    always@(posedge clk) begin    
        
        if(trigger == 1 && isUp == 0) begin // trigger sets the first value of the M-Sequence.
            average = sum / count;
            count = 0;
            sum = 0;
            isUp = 1;
        end else if(trigger == 0 && isUp == 1) begin
            isUp = 0;
        end
            
    end
    
    always@(posedge clk) begin
    
        vAc = memory[count] - average;
                      
        sum = sum + vacIn;
        memory[count] = vacIn;
        count = count +1;  
                           
    end 
        
        
                
        
        
endmodule
