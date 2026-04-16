#include "sobel.h"

// Sobel Edge Detection Filter
// Synthesizable with Vivado HLS — no pragmas (default scheduling)

void sobel_filter(pixel_t *src, pixel_t *dst) {

    // Sobel kernels
    const int Gx[3][3] = {
        {-1,  0,  1},
        {-2,  0,  2},
        {-1,  0,  1}
    };
    const int Gy[3][3] = {
        { 1,  2,  1},
        { 0,  0,  0},
        {-1, -2, -1}
    };

    // Process each pixel (borders are set to 0)
    for (int y = 0; y < HEIGHT; y++) {
        for (int x = 0; x < WIDTH; x++) {

            // Border pixels — no valid 3x3 neighborhood
            if (y == 0 || y == HEIGHT - 1 || x == 0 || x == WIDTH - 1) {
                dst[y * WIDTH + x] = 0;
                continue;
            }

            int sum_x = 0;
            int sum_y = 0;

            // Apply 3x3 Sobel kernels
            for (int ky = -1; ky <= 1; ky++) {
                for (int kx = -1; kx <= 1; kx++) {
                    int pixel = (int)src[(y + ky) * WIDTH + (x + kx)];
                    sum_x += pixel * Gx[ky + 1][kx + 1];
                    sum_y += pixel * Gy[ky + 1][kx + 1];
                }
            }

            // Gradient magnitude approximation (avoid sqrt for HLS efficiency)
            int abs_x = (sum_x < 0) ? -sum_x : sum_x;
            int abs_y = (sum_y < 0) ? -sum_y : sum_y;
            int mag = abs_x + abs_y;

            // Clamp to [0, 255]
            if (mag > 255) mag = 255;

            dst[y * WIDTH + x] = (pixel_t)mag;
        }
    }
}
