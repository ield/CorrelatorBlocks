`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ALTER/UPM
// Engineer: ield
// 
//////////////////////////////////////////////////////////////////////////////////


module dcAcTestBench();
//////////////////////////////////////////////////////////////////////////////////////
//    reg[15:0] vacIn_tb;
//    wire[15:0] vacOut_tb;
    

// Test done to check ho the substractions work    
//    initial
//    begin
//        vacIn_tb = 16'b0000000000000101;
//        #5
//        vacIn_tb = 16'b0000000000000000;
//        #5
//        vacIn_tb = 16'b1111111111111111;
//    end

//    dcAcConverter dcAcConverter(vacIn_tb, vacOut_tb);
/////////////////////////////////////////////////////////////////////////////////////

    reg clk;
    reg[15:0] vacIn_tb;
    reg trigger;
    wire[15:0] vacOut_tb;
    

// Test done to check that the memory works and 
    initial begin
        trigger = 1;
        clk = 1;
        vacIn_tb = 16'b0000000000000101; 
    end
    
    //Control the clock
    always begin
        #1
        clk = ~clk;
        
    end
    
    //Control the input signal
    always begin
        #2
        if(vacIn_tb == 16'b0000000000000101) begin
            vacIn_tb = 16'b0000000000000000;
        end else begin
            vacIn_tb = 16'b0000000000000101;
        end       
    end
    
    //Control the trigger
    always begin
        #8
        trigger = 0; 
        #2032
        trigger = 1;     
    end

    dcAcConverter dcAcConverter(clk, vacIn_tb, trigger, vacOut_tb);
    
////////////////////////////////////////////////////////////////////////////////////////

    
endmodule
