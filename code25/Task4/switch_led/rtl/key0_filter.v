module key0_filter(
    input           clk,
    input           rstn,
    input           key_in,
    output          key_pulse
);

wire key;
assign key = key_in;

reg  [19:0] treg;
wire [19:0] treg_nxt = treg + 1'b1;

always @ (posedge clk or negedge rstn) begin
    if (~rstn) begin
        treg <= 20'b0;
    end
    else begin
        if (key) begin 
            if (treg != 20'hfffff)
                treg <= treg_nxt;
        end
        else begin
            treg <= 20'b0;
        end
    end
end

assign key_pulse = (treg != 20'hfffff) & (treg_nxt == 20'hfffff);

endmodule
