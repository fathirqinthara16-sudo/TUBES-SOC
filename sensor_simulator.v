module sensor_simulator (
    input  wire clk,
    input  wire rst_n,
    output reg [7:0] temp,
    output reg [7:0] hum
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            temp <= 25;
            hum  <= 60;
        end else begin
            temp <= temp + 1;
            hum  <= hum + 2;
        end
    end
endmodule
