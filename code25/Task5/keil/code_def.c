#include "code_def.h"
#include <stdint.h>

// Display a number on 4-digit 7-segment display
void display_number(uint32_t number)
{
    // Extract each digit (ones, tens, hundreds, thousands)
    uint32_t digits[4] = {0, 0, 0, 0};
    uint32_t temp = number;
    
    for(int i = 0; i < 4; i++) {
        digits[i] = temp % 10;
        temp = temp / 10;
    }
    
    // Write to display in reverse order (from thousands to ones)
    for(int i = 3; i >= 0; i--) {
        Segdisp_data = 16 + digits[i];  // 16 = (1 << 4) for enable
    }
}

// Display state on the first digit, and value on the last 3 digits
void display_state_val(uint32_t state, uint32_t val)
{
    // Digit 3 (Leftmost): State
    Segdisp_data = 16 + (state % 10);
    
    // Digit 2: Hundreds
    Segdisp_data = 16 + ((val / 100) % 10);
    
    // Digit 1: Tens
    Segdisp_data = 16 + ((val / 10) % 10);
    
    // Digit 0 (Rightmost): Ones
    Segdisp_data = 16 + (val % 10);
}
