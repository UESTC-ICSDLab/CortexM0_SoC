module Segdisp(
    input           clk,
    input           rstn,
    input   [4:0]   data_in,
    output  [5:0]   seg_sel,
    output  [7:0]   seg_led
);

wire clk_1ms;
/********** 需要补充的代码 **********/
/*: 请在此处实例化时钟分频模块 (clk_division)
   提示：
   1. 模块名：clk_division
   2. 需要设置参数 DIVCLK_CNTMAX 为 24_999
   3. 端口连接
*/

wire [2:0] bit_disp;
/********** 需要补充的代码 **********/
/*: 请在此处实例化扫描计数器模块 (counter)
   提示：
   1. 模块名：counter
   2. 端口连接
*/

wire [23:0] data_nxt;
wire en;
reg  [23:0] data;

assign data_nxt = {data[19:0],data_in[3:0]};
assign en = data_in[4];
always @(posedge clk) begin
    if (!rstn) begin
        data <= 24'b0;
    end else begin
        if (en) begin
            data <= data_nxt;       
        end        
    end
end

wire [3:0] data_disp;
Mux Mux(
     .sel(bit_disp)
    ,.dina(data[3:0])
    ,.dinb(data[7:4])
    ,.dinc(data[11:8])
    ,.dind(data[15:12])
    ,.dine(data[19:16])
    ,.dinf(data[23:20])
    ,.data_out(data_disp)
);

seg_sel_decoder seg_sel_decoder(
    .bit_disp(bit_disp),
    .seg_sel(seg_sel)
);

seg_led_decoder seg_led_decoder(
    .data_disp(data_disp),
    .seg_led(seg_led)
);
endmodule