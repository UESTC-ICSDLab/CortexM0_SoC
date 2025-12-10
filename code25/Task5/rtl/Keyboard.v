module Keyboard(
    input                 clk,           
    input                 rstn,          
    input                 key_clear,     
    input        [3 :0]   col,           
    output       [3 :0]   row,           
    output                key_interrupt, 
    output       [15:0]   key_data,      
    output       [1 :0]   row_index      
);

wire  [15:0]  key; 
/********** 需要补充的代码 **********/
/*: 请在此处实例化 keyboard_scan 模块
   提示：
   1. 模块名：keyboard_scan
   2. 端口连接
*/

wire [15:0] key_pulse; 
/********** 需要补充的代码 **********/
/*: 请在此处实例化 keyboard_filter 模块
   提示：
   1. 模块名：keyboard_filter
   2. 端口连接
*/

// 生成中断信号
// 只要任意一个按键产生脉冲，就触发中断
assign key_interrupt = |key_pulse ;

keyboard_reg keyboard_reg(
     .clk(clk)
    ,.rstn(rstn)
    ,.key_clear(key_clear)
    ,.key_pulse(key_pulse)
    ,.key_reg(key_data)
);

// 计算当前行索引：row 轮流变化 1110→1101→1011→0111
// 对应行索引 0→1→2→3
wire [1:0] row_index_calc;
assign row_index_calc = (row == 4'b1110) ? 2'd0 :
                        (row == 4'b1101) ? 2'd1 :
                        (row == 4'b1011) ? 2'd2 : 2'd3;
assign row_index = row_index_calc;

endmodule