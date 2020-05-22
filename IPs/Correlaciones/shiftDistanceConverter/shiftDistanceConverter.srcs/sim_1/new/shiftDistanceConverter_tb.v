`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ALTER/UPM
// Engineer: ield
// 
//////////////////////////////////////////////////////////////////////////////////


module shiftDistanceConverter_tb();
    reg clk;
    reg[7:0] posMax;
    reg[31:0] corrMax;
    reg[31:0] corrAnt;
    reg[31:0] corrPost;
    wire[15:0] distance;
    wire [15:0] distanceInterpole;
    

// Test done to check that the memory works and 
    initial begin
        
        clk = 1;
        posMax = 16'b1010;
        corrMax = 50;
        corrAnt = 10;
        corrPost = 0; 
        
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
        posMax = posMax + 10;
      
    end

    shiftDistanceConverter shiftDistanceConverter(clk, posMax, corrMax, corrAnt, corrPost, distance, distanceInterpole);
    
////////////////////////////////////////////////////////////////////////////////////////

    
endmodule
