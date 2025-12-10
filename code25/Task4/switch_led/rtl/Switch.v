module Switch(
    input                 clk,
    input                 rstn,
    input                 key_clear,
    input        [3:0]    col,
    output       [3:0]    row,
    input        [3:0]    switch_in,
    output                key_interrupt,
    output       [3:0]    switch_data
);

wire key0;
assign key0 = col[0];
assign row = 4'b1110;

wire key0_pulse;
key0_filter key0_filter(
     .clk(clk)
    ,.rstn(rstn)
    ,.key_in(key0)
    ,.key_pulse(key0_pulse)
);

assign key_interrupt = key0_pulse;

reg [3:0] switch_reg;
always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        switch_reg <= 4'b0;
    end else if (key0_pulse) begin
        switch_reg <= switch_in;
    end else if (key_clear) begin
        switch_reg <= 4'b0;
    end
end

assign switch_data = switch_reg;

endmodule
