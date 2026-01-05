module bcd_converter (
    input  wire [7:0] bin,
    output wire [3:0] tens,
    output wire [3:0] units
);

    assign tens  = bin / 10;
    assign units = bin % 10;

endmodule
