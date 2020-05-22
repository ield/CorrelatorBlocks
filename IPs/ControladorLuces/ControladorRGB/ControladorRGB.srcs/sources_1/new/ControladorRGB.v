`timescale 1ns / 1ps
/**
* Company: ALTER, TFB-UPM
* Engineer: ield
* Create Date: 10.01.2020
* Description:  controls the RGB LEDS with the frequency or
*               when a reset is performed.
*               When the reset is performed the leds are white.
*               When f1 leds turn red
*               When f2 leds turn green
*               When f3 leds turn blue
*/


module ControladorRGB(
    input[1:0] clk1,
    input rst,
    input clk,
    output rgb0r,
    output rgb0g,
    output rgb0b,
    output rgb1r,
    output rgb1g,
    output rgb1b
    );
    
    /**
    * RGB LED control with frequecy
    * When reset leds turn white
    * When f1 leds turn red
    * When f2 leds turn green
    * When f3 leds turn blue
    */
    reg[7:0] r0, r1, g0, g1, b0, b1;
    reg f1, f2, f3;
    pwm pwm_led0_r (
        .clk(clk),
        .i_duty(r0),
        .o_state(rgb0r)
    );

    pwm pwm_led0_g (
        .clk(clk),
        .i_duty(g0),
        .o_state(rgb0g)
    );

    pwm pwm_led0_b (
        .clk(clk),
        .i_duty(b0),
        .o_state(rgb0b)
    );
    
    pwm pwm_led1_r (
        .clk(clk),
        .i_duty(r1),
        .o_state(rgb1r)
    );

    pwm pwm_led1_g (
        .clk(clk),
        .i_duty(g1),
        .o_state(rgb1g)
    );

    pwm pwm_led1_b (
        .clk(clk),
        .i_duty(b1),
        .o_state(rgb1b)
    );
    
    /*
    * Esto controla los colores de los leds en las frecuencias
    */
    always @ (posedge clk) begin
        if(rst == 1) begin
            r0 = 255;
            r1 = 255;
            g0 = 255;
            g1 = 255;
            b0 = 255;
            b1 = 255;
        end
        else if(clk1 == 2'b00) begin
            r0 = 255;
            r1 = 255;
            g0 = 0;
            g1 = 0;
            b0 = 0;
            b1 = 0;
        end
        else if(clk1 == 2'b01) begin
            r0 = 0;
            r1 = 0;
            g0 = 255;
            g1 = 255;
            b0 = 0;
            b1 = 0;
        end
        else if(clk1 == 2'b10) begin
            r0 = 0;
            r1 = 0;
            g0 = 0;
            g1 = 0;
            b0 = 255;
            b1 = 255;
        end
    
    end
    
    
endmodule
