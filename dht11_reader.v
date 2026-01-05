module dht11_reader (
    input  wire clk,
    input  wire KEY0,          // reset (active low)
    inout  wire dht_data,
    output wire [6:0] seg_tens,
    output wire [6:0] seg_units,
    output wire LEDR0,         // temperature indicator
    output wire LEDR1          // humidity indicator
);

    // =============================
    // DHT11 SIGNALS
    // =============================
    reg [39:0] data_buffer;
    reg [5:0]  bit_index;
    reg [19:0] counter;
    reg [25:0] counter_new_temp;
    reg        previous_data;
    reg [2:0]  state;
    reg        data_direction;
    reg        data_reg;

    reg [7:0] temp;
    reg [7:0] humidity;

    // =============================
    // DISPLAY CONTROL
    // =============================
    reg display_mode;          // 0=temp, 1=humidity
    reg [31:0] display_timer;

    parameter AUTO_SWITCH = 250_000_000; // 5 detik @50MHz

    // =============================
    // DHT11 STATE MACHINE + RESET
    // =============================
    always @(posedge clk) begin
        if (!KEY0) begin
            state <= 0;
            bit_index <= 0;
            counter <= 0;
            counter_new_temp <= 0;
            previous_data <= 0;
            data_direction <= 0;
            temp <= 0;
            humidity <= 0;
        end else begin
            data_reg <= dht_data;

            if (counter_new_temp > 50000000) begin
                state <= 0;
                bit_index <= 0;
                counter <= 0;
                counter_new_temp <= 0;
            end else
                counter_new_temp <= counter_new_temp + 1;

            case (state)
                0: begin
                    data_direction <= 0;
                    if (counter > 901000) begin
                        counter <= 0;
                        data_direction <= 1;
                        state <= 1;
                    end else
                        counter <= counter + 1;
                end

                1: if (~data_reg) state <= 2;
                2: if ( data_reg) state <= 3;
                3: if (~data_reg) state <= 4;
                4: if ( data_reg) state <= 5;
                5: if (~data_reg) state <= 6;

                6: begin
                    if (bit_index < 40) begin
                        if (~data_reg && previous_data) begin
                            data_buffer[39-bit_index] <= (counter > 2500);
                            counter <= 0;
                            bit_index <= bit_index + 1;
                        end
                        if (data_reg)
                            counter <= counter + 1;
                    end else begin
                        humidity <= data_buffer[39:32];
                        temp     <= data_buffer[23:16];
                        state <= 0;
                    end
                    previous_data <= data_reg;
                end
            endcase
        end
    end

    assign dht_data = (data_direction) ? 1'bz : 1'b0;

    // =============================
    // AUTO SWITCH DISPLAY (5 DETIK)
    // =============================
    always @(posedge clk) begin
        if (!KEY0) begin
            display_timer <= 0;
            display_mode <= 0;   // default temp
        end else begin
            display_timer <= display_timer + 1;
            if (display_timer >= AUTO_SWITCH) begin
                display_timer <= 0;
                display_mode <= ~display_mode;
            end
        end
    end

    // =============================
    // DISPLAY SELECTION
    // =============================
    wire [7:0] display_value;
    assign display_value = (display_mode == 1'b0) ? temp : humidity;

    wire [3:0] tens  = display_value / 10;
    wire [3:0] units = display_value % 10;

    seven_seg_decoder seg1 (.digit(tens),  .seg(seg_tens));
    seven_seg_decoder seg0 (.digit(units), .seg(seg_units));

    // =============================
    // LED MODE INDICATOR
    // =============================
    assign LEDR0 = (display_mode == 1'b0); // temp
    assign LEDR1 = (display_mode == 1'b1); // humidity

endmodule


// ===================================
// SEVEN SEGMENT DECODER ACTIVE LOW
// ===================================
module seven_seg_decoder (
    input  wire [3:0] digit,
    output reg  [6:0] seg
);
    always @(*) begin
        case (digit)
            4'd0: seg = 7'b1000000;
            4'd1: seg = 7'b1111001;
            4'd2: seg = 7'b0100100;
            4'd3: seg = 7'b0110000;
            4'd4: seg = 7'b0011001;
            4'd5: seg = 7'b0010010;
            4'd6: seg = 7'b0000010;
            4'd7: seg = 7'b1111000;
            4'd8: seg = 7'b0000000;
            4'd9: seg = 7'b0010000;
            default: seg = 7'b1111111;
        endcase
    end
endmodule
