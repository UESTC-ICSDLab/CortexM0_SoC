#include "code_def.h"
#include <string.h>
#include <stdint.h>

#define WaterLight_SPEED_VALUE 0x00c9d2ff

int main()
{ 
    //interrupt initial
    NVIC_CTRL_ADDR = 0xf;

    //WATERLIGHT
    SetWaterLightSpeed(WaterLight_SPEED_VALUE);
    while(1){    
    }
}