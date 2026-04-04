#include <stdint.h>

// DPI-C function to match SystemVerilog byte (8-bit)
int8_t c_ref_c(int8_t val) {
    uint8_t x = (uint8_t)val;
    for (int i = 0; i < 3; i++) {
        x = 2 * x + 1;
    }
    return (int8_t)x;
}
