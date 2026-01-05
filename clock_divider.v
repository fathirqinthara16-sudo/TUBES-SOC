module clock_divider #(
    parameter DIV = 4
)(
    input  wire clk_in,
    input  wire rst_n,
    output reg  clk_out
);

    reg [$clog2(DIV)-1:0] cnt;

    always @(posedge clk_in or negedge rst_n) begin
        if (!rst_n) begin
            cnt <= 0;
            clk_out <= 0;
        end else if (cnt == DIV-1) begin
            cnt <= 0;
            clk_out <= ~clk_out;
        end else begin
            cnt <= cnt + 1;
        end
    end

endmodule
