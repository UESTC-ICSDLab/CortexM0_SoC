#include "code_def.h"
#include <string.h>
#include <stdint.h>

int main()
{   
	NVIC_CTRL_ADDR	= 1;  
    while(1){
		uint32_t din;
	    int i = 0;
	    int ans = 0;
		while(!key_flag){};
		din = Keyboard_keydata_clear;
		for (i = 0; i < 16; i++) {
		    if ((din >> i) & 1) {
		    	ans = i;
			    Segdisp_data = (uint32_t)(16 + ans); //enable
			    break;
			}
		}
		key_flag = 0;
		Keyboard_keydata_clear = 1;
	}  
}
