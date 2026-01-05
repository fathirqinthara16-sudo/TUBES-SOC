module DHT (
    input  wire clk,
    input  wire rst_n,
    output wire [6:0] seg_tens,
    output wire [6:0] seg_units,
    output wire LEDR0,
    output wire LEDR1
);

    // =========================
    // PARAMETER SIMULASI CEPAT
    // =========================
    parameter SIM_SWITCH = 5;   // anggap 5 detik (SIMULASI)

    // =========================
    // FSM STATE DECLARATION
    // =========================
    parameter S_TEMP = 2'd0,
              S_WAIT = 2'd1,
              S_HUM  = 2'd2;

    reg [1:0] state, next_state;

    // =========================
    // INTERNAL SIGNAL
    // =========================
    wire slow_clk;
    reg  [3:0] switch_cnt;

    // =========================
    // CLOCK DIVIDER (SIMULASI)
    // =========================
    clock_divider #(.DIV(4)) u_clk (
        .clk_in(clk),
        .rst_n(rst_n),
        .clk_out(slow_clk)
    );

    // =========================
    // FSM STATE REGISTER
    // =========================
    always @(posedge slow_clk or negedge rst_n) begin
        if (!rst_n)
            state <= S_TEMP;
        else
            state <= next_state;
    end

    // =========================
    // FSM NEXT STATE LOGIC
    // (INI YANG DIBACA QUARTUS)
    // =========================
    always @(*) begin
        next_state = state;
        case (state)
            S_TEMP: if (switch_cnt == SIM_SWITCH-1) next_state = S_WAIT;
            S_WAIT:                                next_state = S_HUM;
            S_HUM : if (switch_cnt == SIM_SWITCH-1) next_state = S_TEMP;
            default:                               next_state = S_TEMP;
        endcase
    end

    // =========================
    // FSM OUTPUT + COUNTER
    // =========================
    always @(posedge slow_clk or negedge rst_n) begin
        if (!rst_n) begin
            switch_cnt <= 0;
        end else begin
            if (state != next_state)
                switch_cnt <= 0;
            else
                switch_cnt <= switch_cnt + 1;
        end
    end

    // =========================
    // LED INDIKATOR MODE
    // =========================
    assign LEDR0 = (state == S_TEMP); // suhu
    assign LEDR1 = (state == S_HUM);  // humidity

    // =========================
    // NILAI DISPLAY FIX
    // =========================
    wire [7:0] display_value;
    assign display_value = (state == S_TEMP) ? 8'd25 : 8'd54;

    // =========================
    // BCD CONVERTER
    // =========================
    wire [3:0] tens;
    wire [3:0] units;

    bcd_converter u_bcd (
        .bin(display_value),
        .tens(tens),
        .units(units)
    );

    // =========================
    // SEVEN SEGMENT
    // =========================
    seven_segment_decoder u_seg_tens (
        .digit(tens),
        .seg(seg_tens)
    );

    seven_segment_decoder u_seg_units (
        .digit(units),
        .seg(seg_units)
    );

endmodule
