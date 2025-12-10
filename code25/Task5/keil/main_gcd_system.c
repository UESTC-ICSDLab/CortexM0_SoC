#include "code_def.h"
#include <stdint.h>

// 简单的延时函数
void delay(int count) {
    volatile int i;
    for (i = 0; i < count; i++);
}

// 状态定义
#define STATE_INPUT_A  1
#define STATE_INPUT_B  2
#define STATE_RESULT   3

int main(void)
{
    uint32_t key_val;
    uint32_t current_state = STATE_INPUT_A;
    uint32_t num_a = 0;
    uint32_t num_b = 0;
    uint32_t gcd_res = 0;
    int i;
    int digit_input = -1;

    // 初始化：清除键盘状态
    KEY_DATA = 1; 

    // 初始显示
    display_state_val(current_state, num_a);

    while(1)
    {
        // 读取键盘状态
        key_val = KEY_DATA & 0xFFFF;

        if (key_val != 0)
        {
            // 1. 解析按键 (1-16)
            int key_num = 0;
            for (i = 0; i < 16; i++)
            {
                if (key_val & (1 << i))
                {
                    key_num = i + 1;
                    break;
                }
            }

            // 2. 处理按键逻辑
            if (key_num == 16) 
            {
                // --- 状态切换逻辑 ---
                if (current_state == STATE_INPUT_A)
                {
                    current_state = STATE_INPUT_B;
                    display_state_val(current_state, num_b);
                }
                else if (current_state == STATE_INPUT_B)
                {
                    current_state = STATE_RESULT;
                    
                    // 启动 GCD 计算
                    /********** 需要补充的代码 **********/
                    /* 在此处填写启动 GCD 的代码                   
                       1) 先把操作数写入外设寄存器（按顺序写入 A、B）
                       2) 写入控制寄存器触发计算（写 1 表示启动）
                    */
                    
                    // 等待完成
                    while((GCD_RESULT & 0x80000000) == 0);
                    
                    // 获取结果
                    /********** 需要补充的代码 **********/
                    /* : 在此处填写读取结果的代码（示例提示如下）
                       读取结果寄存器并屏蔽完成位：
                        gcd_res = XXX & XXX ;
                    */
                    
                    display_state_val(current_state, gcd_res);
                }
                else if (current_state == STATE_RESULT)
                {
                    // 重置回状态 1
                    current_state = STATE_INPUT_A;
                    num_a = 0;
                    num_b = 0;
                    gcd_res = 0;
                    display_state_val(current_state, num_a);
                }
            }
            else if (key_num >= 1 && key_num <= 10)
            {
                // --- 数字输入逻辑 ---
                // 映射按键：1-9 -> 1-9, 10 -> 0
                if (key_num == 10) digit_input = 0;
                else digit_input = key_num;

                if (current_state == STATE_INPUT_A)
                {
                    // 输入 A，限制为 3 位 (0-999)
                    if (num_a < 100) 
                    {
                        num_a = num_a * 10 + digit_input;
                        display_state_val(current_state, num_a);
                    }
                }
                else if (current_state == STATE_INPUT_B)
                {
                    // 输入 B，限制为 3 位
                    if (num_b < 100) 
                    {
                        num_b = num_b * 10 + digit_input;
                        display_state_val(current_state, num_b);
                    }
                }
                // 状态 3 下数字键无效
            }

            // 3. 清除键盘中断状态
            KEY_DATA = 1; 

            // 4. 延时防抖
            delay(50000); 
        }
    }
    
    return 0;
}
