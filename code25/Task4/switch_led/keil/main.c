#include "code_def.h"
#include <string.h>
#include <stdint.h>

int main()
{   
    NVIC_CTRL_ADDR = 1;  // Enable interrupt
    while(1){
		uint32_t switch_value;
		
		// Wait for key0 interrupt
		while(!key_flag){};
		
		// Read switch data (4 bits)
		switch_value = Switch_data & 0x0F;
		
		// Write to segment display (bit[4]=1 for enable, bit[3:0]=data)
		Segdisp_data = (uint32_t)(16 + switch_value);
		
		// Clear flag and switch register
		key_flag = 0;
		Switch_data = 1;
	}  
}
