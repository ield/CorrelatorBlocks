`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ALTER/UPM
// Engineer: ield
// 
//////////////////////////////////////////////////////////////////////////////////


module corrMemory_tb();
    reg clk;
    reg rst;
    reg trigger;
    reg trig_root;
    reg[31:0] corr;
    wire[31:0] corrMax;
    wire[31:0] corrMaxAnt;
    wire[31:0] corrMaxPost;
    wire[7:0] posMax;
    wire[15:0] corrSnr;
    wire[15:0] corrSup;

    initial begin
        rst = 1;
        trigger = 1;
        clk = 1;
        trig_root = 1;
        corr = 16'b0000000000000101; 
        #2
        rst = 0;
    end
    
    //Control the clock
    always begin
        #1
        clk = ~clk;
        
    end
    
    //Control the input signal
    always begin
        #124440
        corr = 40;
        #510
        //Change RX
        corr = 5;
        
        #5100
        //Change RX
        corr = 5;
    end
    
    //Control the trigger
    always begin
        #2
        trigger = 0;    
        #508
        trigger = 1;  
    end
    //Controls the trigger root
    always begin//CAMBIAR TRIG_ROOT
        #2
        trig_root = 0;
        #130048
        trig_root = 1;
    end

    corrMemory corrMemory(clk, rst, trigger, trig_root, corr, corrMax, corrMaxAnt, corrMaxPost, posMax, corrSnr, corrSup);
    
////////////////////////////////////////////////////////////////////////////////////////

    
endmodule
