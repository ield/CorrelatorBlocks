`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ALTER/UPM
// Engineer: ield
// 
//////////////////////////////////////////////////////////////////////////////////


module timeCorrelator_tb();


    reg clk;
    reg[15:0] rxAc;
    reg txShift;
    reg trigger;
    wire[31:0] correlation;
    wire corrReady;
    

// Test done to check that the memory works and 
    initial begin
        trigger = 1;
        clk = 1;
        rxAc = 16'b0000000000000101; 
        txShift = 0;
    end
    
    //Control the clock
    always begin
        #1
        clk = ~clk;
        
    end
    
    //Control the input signal
    always begin
        #2
        //Change RX
        if(rxAc == 16'b0000000000000101) begin
            rxAc = 16'b1111111111111011;
        end else begin
            rxAc = 16'b0000000000000101;
        end
        
//        //Change tx
//        if(txShift == 1) begin
//            txShift = 0;
//        end else begin
//            txShift = 1;        
//        end       
    end
    
    //Control the trigger
    always begin
        #8
        trigger = 0;    
        #502
        trigger = 1;  
    end

    timeCorrelator timeCorrelator(clk, rxAc, txShift, trigger, correlation, corrReady);
    
////////////////////////////////////////////////////////////////////////////////////////

    
endmodule
