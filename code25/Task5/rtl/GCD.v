module GCD(
    input clk,
    input RSTn,
    input start,
    input [31:0] a,
    input [31:0] b,
    output reg [31:0] result,
    output reg done
);

reg [31:0] reg_a;
reg [31:0] reg_b;
reg [1:0] state;

localparam IDLE = 2'b00;
localparam CALC = 2'b01;
localparam DONE = 2'b10;

always @(posedge clk or negedge RSTn) begin
    if(~RSTn) begin
        reg_a <= 32'd0;
        reg_b <= 32'd0;
        result <= 32'd0;
        done <= 1'b0;
        state <= IDLE;
    end else begin
        case(state)
            IDLE: begin
                done <= 1'b0;
                if(start) begin
                        /********** 需要补充的代码 **********/
                        // 提示: 加载输入数据到 a_reg 和 b_reg, 切换到 CALC 状态
                        
                        /************************************/
                end
            end
            
            CALC: begin
                if(reg_b == 32'd0) begin
                    result <= reg_a;
                    done <= 1'b1;
                    state <= DONE;
                end else if(reg_a > reg_b) begin
                        /********** 需要补充的代码 **********/
                end else begin
                        /********** 需要补充的代码 **********/
                end
            end
            
            DONE: begin
                // Stay in DONE state, ready for next computation
                // Done flag stays high until next start
                if(start) begin
                    done <= 1'b0;
                    reg_a <= a;
                    reg_b <= b;
                    state <= CALC;
                end
            end
            
            default: state <= IDLE;
        endcase
    end
end

endmodule
