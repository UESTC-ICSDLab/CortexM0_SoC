module clk_division #(
    parameter DIVCLK_CNTMAX = 24999
)(
    input   clk_in,
    input   rstn,
    output  divclk
);

reg [31:0] cnt;              
reg divclk_reg;

/********** 需要补充的代码 **********/
/*: 请在此处编写时钟分频逻辑
   提示：
   1. 这是一个时序逻辑块，敏感列表应包含时钟上升沿和复位下降沿。
   2. 当复位信号有效（低电平）时，计数器 cnt 和输出寄存器 divclk_reg 应清零。
*/

assign divclk = divclk_reg;

endmodule