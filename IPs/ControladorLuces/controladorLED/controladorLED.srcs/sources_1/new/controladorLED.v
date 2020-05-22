`timescale 10ns / 1ns
/**
* Company: ALTER, TFB-UPM
* Engineer: ield
* Create Date: 10.01.2020
* Description:  controls the LEDS when the move btn is pressedn or
*               when a reset is performed.
*               When the reset is performed the leds blink twice.
*               When the move is donde, the leds move from left to right or
*                   from right to left depending on updown
*               The reset is more powerful than the move: A reset order 
*                   stops the move (and not the other way around.
*/


module controladorLED(
    input updown,
    input move,
    input rst,
    input clk,
    output led1,
    output led2,
    output led3,
    output led4
    );
    
    /**
    * LED control with movement
    * When shifting left, leds turn on flipping left
    * like in delorean lights
    * The opposite happens when shifting right
    *
    * Cont_move cuenta el numero de flanco de reloj que debe permanecer un led encendido
    * Moving se activa cuando ha habido un flanco y se desactiva cuando haya terminado el movimiento
    */
    reg[31:0] cont_move, cont_rst;
    reg moving;
    reg rstUp;
    reg l1, l2, l3, l4;
    wire[31:0] cte = 10000000;
    
    assign led1 = l1;
    assign led2 = l2;
    assign led3 = l3;
    assign led4 = l4;
    
    //Para activar move se necesita que 
        //1. Se haya activado el reset al principio
        //2. Es reset este bajo.
    
    always @ (posedge clk) begin
        if(rst == 1) begin
            rstUp = 1;
            cont_rst = 0'b0;
        end
        
        if(move == 1) begin
            moving = 1;
            cont_move = 0'b0;
        end
        
        if (rstUp == 1) begin
            moving = 0;
            cont_rst= cont_rst + 1;
            if(cont_rst < cte) begin
                l1 = 1;
                l2 = 1;
                l3 = 1;                   
                l4 = 1;
            end
            else if(cont_rst > cte && cont_rst < 2*cte) begin
                l1 = 0;
                l2 = 0;
                l3 = 0;                   
                l4 = 0;
            end
            else if(cont_rst > 2*cte && cont_rst < 3*cte) begin
                l1 = 1;
                l2 = 1;
                l3 = 1;                   
                l4 = 1;
            end
            else if(cont_rst > 3*cte) begin
                l1 = 0;
                l2 = 0;
                l3 = 0;                   
                l4 = 0;
                rstUp = 0;
            end
        end
        
        if (moving == 1) begin
            cont_move= cont_move + 1;
            if(updown == 1) begin //Cuando se esta moviendo a derechas
                if(cont_move < cte) begin
                    l1 = 0;
                    l2 = 0;
                    l3 = 0;                   
                    l4 = 1;
                end
                else if(cont_move > cte && cont_move < 2*cte) begin
                    l1 = 0;
                    l2 = 0;
                    l3 = 1;                   
                    l4 = 0;
                end
                else if(cont_move > 2*cte && cont_move < 3*cte) begin
                    l1 = 0;
                    l2 = 1;
                    l3 = 0;                   
                    l4 = 0;
                end
                else if(cont_move > 3*cte && cont_move < 4*cte) begin
                    l1 = 1;
                    l2 = 0;
                    l3 = 0;                   
                    l4 = 0;
                end
                if(cont_move > 4*cte) begin
                    l1 = 0;
                    l2 = 0;
                    l3 = 0;                   
                    l4 = 0;
                    moving = 0;
                end
            end
            else begin//Cuando se esta moviendo a izquierdas
                if(cont_move < cte) begin
                    l1 = 1;
                    l2 = 0;
                    l3 = 0;                   
                    l4 = 0;
                end
                else if(cont_move > cte && cont_move < 2*cte) begin
                    l1 = 0;
                    l2 = 1;
                    l3 = 0;                   
                    l4 = 0;
                end
                else if(cont_move > 2*cte && cont_move < 3*cte) begin
                    l1 = 0;
                    l2 = 0;
                    l3 = 1;                   
                    l4 = 0;
                end
                else if(cont_move > 3*cte && cont_move < 4*cte) begin
                    l1 = 0;
                    l2 = 0;
                    l3 = 0;                   
                    l4 = 1;
                end
                if(cont_move > 4*cte) begin
                    l1 = 0;
                    l2 = 0;
                    l3 = 0;                   
                    l4 = 0;
                    moving = 0;
                end
            end
        end
    end
endmodule
