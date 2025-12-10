#include <stdint.h>

//GCD Hardware Accelerator DEF (0x40000000-0x4000000F)
#define GCD_A      (*(volatile uint32_t *)0x40000000)
#define GCD_B      (*(volatile uint32_t *)0x40000004)
#define GCD_CTRL   (*(volatile uint32_t *)0x40000008)
#define GCD_RESULT (*(volatile uint32_t *)0x4000000C)

//Segment Display DEF (0x40000010-0x4000001F)
#define Segdisp_data (*(volatile uint32_t *)0x40000010)

//Keyboard DEF (0x40000014)
#define KEY_DATA   (*(volatile uint32_t *)0x40000014)

// Function declarations
void display_number(uint32_t number);
void display_state_val(uint32_t state, uint32_t val);
