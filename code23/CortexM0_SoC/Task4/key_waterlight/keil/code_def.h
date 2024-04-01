#include <stdint.h>

//INTERRUPT DEF
#define NVIC_CTRL_ADDR (*(volatile unsigned *)0xe000e100)

//WATERLIGHT DEF
typedef struct{
    volatile uint32_t Waterlight_MODE;
    volatile uint32_t Waterlight_SPEED; 
}WaterLightType;

#define WaterLight_BASE 0x40000000
#define WaterLight ((WaterLightType *)WaterLight_BASE)


void SetWaterLightMode(int mode);
void SetWaterLightSpeed(int speed);