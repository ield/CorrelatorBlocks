`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ALTER/UPM
// Engineer: ield

//This program converts from shifts to distance in two different methods
//  1. Raw method: the shift is the distance
//  2. Interpolation: to obtain a more accurate measure
//////////////////////////////////////////////////////////////////////////////////


module shiftDistanceConverter(
    input clk,
    //used for normal distance
    input[7:0] posMax,
    //used for interpolation
    input[31:0] corrMax,
    input[31:0] corrAnt,
    input[31:0] corrPost,
    
    output[15:0] distance,
    output[15:0] distanceInterpole
    
    );
    
    // This is (c/n)*tsampling. This multiplies the number of shifts. The real value
    // is 8.1687. The result should be divided by 10000, so that it is more accurate
    localparam factor = 81644;
    localparam[15:0] MEMLENGTH = 255;
    
    //Used for interpolation. Same as Matlab function
    /*
        #1. It figures out the position ant and post
        #2. Decides which is the appropriate point for interpolation
        #3. Then it interpoles. For interpolation, it is multiplied
            first the delay in chips *10 so then it is devided by 
            100000
    */
    integer posAnt, posPost;
    integer x1, x2;
    integer corr1, corr2;
    reg[31:0] disInterpoled;
    
    reg[31:0] disScalated;
    
    assign distance = disScalated / (10000);
    //One 
    assign distanceInterpole = disInterpoled / (10000);
    
    always@(posedge clk) begin    
        //Calculate normal distance
        disScalated = posMax * factor;
        
        //Calculate distance with interpolation
        //#1
        if(posMax == 0)begin
            posAnt = MEMLENGTH - 1;
            posPost = posMax + 1;
        end else if(posMax == MEMLENGTH - 1) begin
            posAnt = posMax-1;
            posPost = 0;
        end else begin
            posAnt = posMax-1;
            posPost = posMax + 1;
        end
        
        //#2
        if(corrAnt >=corrPost) begin
            corr2 = corrMax;
            corr1 = corrAnt;
            x2 = posMax;
            x1 = posAnt;
        end else begin
            corr2 = corrPost;
            corr1 = corrMax;
            x2 = posPost;
            x1 = posMax;
        end
        
        //#3
        //It is multiplied times factor in the order showed so that the divisions
        //are the most accurate posible.
        disInterpoled = (x1*factor + (x2-x1)*(corr2*factor/(corr2 + corr1)));
        
            
    end
            
endmodule
