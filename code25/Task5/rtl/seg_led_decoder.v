module seg_led_decoder(
    input        [3:0]  data_disp,
    output  reg  [7:0]  seg_led
);

always@(data_disp)begin
    /********** 需要补充的代码 **********/
    /*: 请在此处根据数码管字形编码表完成段选译码
       提示：
       1. 使用 case(data_disp) 对 4'h0 ~ 4'hF 进行匹配。
       2. 每个 case 分支赋值 SEG 字形（共阴极，1 表示点亮）。
       3. default 分支可输出 8'h00，避免显示乱码。
    */
end

endmodule

