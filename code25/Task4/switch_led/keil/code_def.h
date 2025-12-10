#include <stdint.h>

//INTERRUPT DEF
#define NVIC_CTRL_ADDR (*(volatile unsigned *)0xe000e100)

//SWITCH DEF
#define Switch_data (*(volatile unsigned *)0x40000000)

//SEGDISP DEF
#define Segdisp_data (*(volatile unsigned *)0x40000010)
	
extern uint32_t key_flag;

void KEY_ISR(void);
