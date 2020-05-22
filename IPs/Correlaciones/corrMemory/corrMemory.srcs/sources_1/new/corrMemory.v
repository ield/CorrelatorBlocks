`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ALTER/UPM
// Engineer: ield

//It is the equivalent to plotting the correlation function. 
//Stores the value of the correlation for different shifts.
//It receives as input the value of the correlation for each shift
//and stores that value in the memory. For instance: for two
//shifts, the correlation is...
//To know the value of the shifts it keeps track of the number of
//iterations since the shifted signal was equal to the transmitted
//one. It is important that it has a delay of one shift: when the
//shifted signal is the transmitted one it is actually receiving the
//last shift
//////////////////////////////////////////////////////////////////////////////////


module corrMemory(
    input clk,
    input rst, //Used to set the value of countAvg to 0
    input trigger,//Everytime the is a shift
    input trig_root,//Informs when the root of the shifted msequence is '11111111'
    input[31:0] corr,
    output[31:0] corrMax,
    output[31:0] corrMaxAnt,
    output[31:0] corrMaxPost,
    output[7:0] posMax,
    output[15:0] SNRCorr,//Saldrá multiplicado por 10
    output[15:0] supCorr
    );
    
    localparam[15:0] MEMLENGTH = 255;
    localparam[7:0] AVERAGES = 64;
    
    reg[31:0] corrRaw[MEMLENGTH-1:0][AVERAGES-1:0];
    reg[31:0] corrAvg[MEMLENGTH-1:0];  
    
    reg[7:0] countCorr; //stores the number of shifts to know what position to enter the memory
    reg[7:0] countAvg;//stores the number of complete correlations done to average
    reg[7:0] countClk;//counts clock periods so that it is reduced the number of calculations
    
    reg[31:0] corrAbs;//stores the absolute value of the correlation
    
     /*
    There is a problem synchronizing the dcAc with the LFSRShift
    because the trigger of the dcAc must arrive at the same time 
    that the rst of the LFSR Up
    However, the clocks are different: 25MHz for the LFSSR and 100
    for the samples. The pulse of the trigger here should be addapted
    from 25MHz to 100MHz.
    */
    reg trigRootIsUp;
    
    integer ii, jj;//Meaningless constants; for countig in loops
    
    //Used for finding the peak of the correlation
    integer max;
    integer pos;
    integer calcAvg;
    reg[31:0] correlationMaximum;
    reg[15:0] positionMaximum;
    
    //Used to calculate snr
    integer noiseRms;
    integer max_3;
    reg[15:0] corrSnr;
    
    //Used to calculate the suppression
    integer secondMax;
    reg[15:0] corrSup;
    
    //Used to generate the outputs for the interpolation
    reg[31:0] correlationMaximumAnt;
    reg[31:0] correlationMaximumPost;
    integer posAnt;
    integer posPost;
    
    //Assignations
    //Normal correlation
    assign corrMax = correlationMaximum;
    assign posMax = positionMaximum;
    //Correlation SNR
    assign SNRCorr = corrSnr;
    //Correlation Suppresion
    assign supCorr = corrSup;
    //Interpolation outputs
    assign corrMaxAnt = correlationMaximumAnt;
    assign corrMaxPost = correlationMaximumPost;
    
    always@(posedge clk) begin    
        //The count avg is set to 0 with the reset
        if(rst == 1) begin
            countCorr = MEMLENGTH - 1;
            countAvg = 0;
            countClk = 0;
            trigRootIsUp = 0;
            corrSnr = 0;
        
        end else if(trig_root == 1 && trigRootIsUp == 0) begin // trigger sets the first value of the M-Sequence.
            countCorr = MEMLENGTH - 1;  
            //1019 because there is a delay: the correlation entering
            //is the one from the last shifted M-Sequence.
            //Mirar si debiera ser 254*4 o 255*4-1. Creo que 254*4.
            //Esto queda para más adelante cuando aumente la memoria de aqui
    
            trigRootIsUp = 1;

            if(countAvg == 63) begin
                countAvg = 0;
            end else begin
                countAvg = countAvg + 1;
            end
        end else if(trig_root == 0 && trigRootIsUp == 1) begin
            trigRootIsUp = 0;
        end
            
    end
    
    always@(posedge clk) begin
    
        if(trigger == 1) begin //everytime the correlation is done
            //#1. Abslut value of the correlation
            if(corr[31] == 1) begin
                corrAbs = ~corr + 1;
            end else begin
                corrAbs = corr;
            end
            
            //#2. Save correlation in memory
            //corrAvg[countCorr] = corrAbs;
            corrRaw[countCorr][countAvg] = corrAbs;
            
            //#3. Refresh the value of countCorr
            if(countCorr == MEMLENGTH - 1) begin
                countCorr = 0;
            end else begin
                countCorr = countCorr + 1;
            end
            
            //#4. Search for the maximum of the correlation function
            max = 0;
            pos = MEMLENGTH;
            for(ii = 0; ii<MEMLENGTH; ii = ii+1) begin    
                if(corrAvg[ii] >= max) begin
                    pos = ii;
                    max = corrAvg[ii];
                end
            end
            correlationMaximum = max;
            positionMaximum = pos;
            
            //#5. Calculates the snr of the correlation
            /**
                #1. It goes all the way through the correlation function except for 
                    the peak of the function. First it is necessary to define the 
                    limits and consider the cases where the maximum is at the extreme
                    values of the correlation function (beginning or end).
                    It only considers the values far away from the peak.
                #2. It adds all the noise
                #3. It divides and calulates the ratio 
            */
            
            //#6. Calcultes the correlation suppression
            /**
                #1. Taking advantage that to calculate the snr of the correlation 
                    it travels all the array, it is looked after the second maximum
                #2. It calculates the ratio
            */
            noiseRms = 0;
            secondMax = 1;
            
            //#5.1
            if(pos >= 0 && pos <= 2)begin
                max_3 = MEMLENGTH-3+pos;
                ii = pos+2;
            end else if(pos >= MEMLENGTH - 2) begin
                max_3 = pos-3;
                ii = pos - (MEMLENGTH - 2);
            end else begin
                max_3 = pos-3;
                ii = pos+2;
            end
          
            ii = pos+1;
            //#5.2
            while(ii != max_3) begin
                if(ii >= MEMLENGTH-1) begin
                    ii = 0;
                end else begin
                    ii = ii + 1;
                end
                noiseRms = noiseRms + corrAvg[ii];
                
                //#6.1 
                if(corrAvg[ii]>secondMax) begin
                    secondMax = corrAvg[ii];
                end
                        
            end
            
            //#5.3
            noiseRms = noiseRms / (MEMLENGTH-5);
            corrSnr = (max*10) / (noiseRms);
            
            //#6.2
            corrSup = (max*10)/secondMax;
            
            //#7. Generates the output for interpolation
            /**
                #1. Taking advantage that to calculate the snr of the correlation 
                    it travels all the array, it uses the position of the maximum
                    and sets the pos of the other maximum, considering especially
                    the limits
                #2. It assigns values
            */
            
            //#1
            if(pos == 0)begin
                posAnt = MEMLENGTH - 1;
                posPost = pos + 1;
            end else if(pos == MEMLENGTH - 1) begin
                posAnt = pos-1;
                posPost = 0;
            end else begin
                posAnt = pos-1;
                posPost = pos + 1;
            end
            
            //#2
            correlationMaximumAnt = corrAvg[posAnt];
            correlationMaximumPost = corrAvg[posPost];
           
        end 
        
        //#5.   Averages the calculations in corresponding to one shift 
        //      every clock period                       
        calcAvg = 0;
        for(ii = 0; ii<AVERAGES; ii = ii+1) begin
            calcAvg = calcAvg + corrRaw[countClk][ii];        
        end
        calcAvg = calcAvg / AVERAGES;
        corrAvg[countClk] = calcAvg;
        
        if(countClk == MEMLENGTH - 1) begin
            countClk = 0;
        end else begin
            countClk = countClk + 1;
        end
                      
    end 
    
endmodule
