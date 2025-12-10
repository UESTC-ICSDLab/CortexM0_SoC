module keyboard_scan(
    input                clk,    
    input                rstn,   
    input        [3 :0]  col,    
    output  reg  [3 :0]  row = 4'b1110, 
    output  reg  [15:0]  key     
);

/********** 需要补充的代码 **********/
/*: 请在此处编写扫描时钟生成逻辑
   提示：
   1. 定义计数器 cnt 和扫描时钟 scan_clk。
   2. 产生扫描时钟 scan_clk：
      - 计数器计数到 2499 翻转 scan_clk，即周期为 5000 个 clk 周期。
      - 若 clk=50MHz，则 scan_clk 频率为 10kHz。
      - 注意复位信号 rstn (低电平有效)。
*/

// 行扫描逻辑
// 在每个scan_clk上升沿，循环左移row信号
// 1110 -> 1101 -> 1011 -> 0111 -> 1110 ...
always@(posedge scan_clk) begin
    row <= {row[2:0],row[3]}; 
end
    
// 按键采样逻辑
// 在scan_clk下降沿采样列数据，确保行信号已稳定
// 根据当前扫描的行(row)，将列数据(col)填入对应的key位
always@(negedge scan_clk) begin
    case(row)
        4'b1110 : key[3:0] <= col;   // 第一行对应 key[3:0]
        4'b1101 : key[7:4] <= col;   // 第二行对应 key[7:4]
        4'b1011 : key[11:8] <= col;  // 第三行对应 key[11:8]
        4'b0111 : key[15:12] <= col; // 第四行对应 key[15:12]
        default : key <= 0;
    endcase
end

endmodule


