`timescale 1ns/1ps
module tb_DHT;

    reg clk;
    reg rst_n;

    wire [6:0] seg_tens;
    wire [6:0] seg_units;
    wire LEDR0;
    wire LEDR1;

    DHT dut (
        .clk(clk),
        .rst_n(rst_n),
        .seg_tens(seg_tens),
        .seg_units(seg_units),
        .LEDR0(LEDR0),
        .LEDR1(LEDR1)
    );

    // CLOCK 50 MHz
    always #10 clk = ~clk;

    initial begin
        clk = 0;
        rst_n = 0;

        #100;
        rst_n = 1;   // RESET DILEPAS

        #200_000;    // SIMULASI PANJANG
        $stop;
    end

endmodule
