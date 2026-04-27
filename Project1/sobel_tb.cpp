#include <cstdio>
#include <cstdlib>
#include <cmath>
#include "sobel.h"

// ---------------------------------------------------------------
// Software reference Sobel (for comparison with HLS output)
// ---------------------------------------------------------------
static void sobel_reference(pixel_t *src, pixel_t *dst) {
    const int Gx[3][3] = {{-1,0,1},{-2,0,2},{-1,0,1}};
    const int Gy[3][3] = {{ 1,2,1},{ 0,0,0},{-1,-2,-1}};

    for (int y = 0; y < HEIGHT; y++) {
        for (int x = 0; x < WIDTH; x++) {
            if (y == 0 || y == HEIGHT-1 || x == 0 || x == WIDTH-1) {
                dst[y*WIDTH+x] = 0;
                continue;
            }
            int sx = 0, sy = 0;
            for (int ky = -1; ky <= 1; ky++)
                for (int kx = -1; kx <= 1; kx++) {
                    int p = (int)src[(y+ky)*WIDTH+(x+kx)];
                    sx += p * Gx[ky+1][kx+1];
                    sy += p * Gy[ky+1][kx+1];
                }
            int mag = abs(sx) + abs(sy);
            if (mag > 255) mag = 255;
            dst[y*WIDTH+x] = (pixel_t)mag;
        }
    }
}

// ---------------------------------------------------------------
// Generate a synthetic test image with clear edges
// ---------------------------------------------------------------
static void generate_test_image(pixel_t *img) {
    for (int y = 0; y < HEIGHT; y++) {
        for (int x = 0; x < WIDTH; x++) {
            // Vertical stripe pattern -- strong vertical edges
            if ((x / 32) % 2 == 0)
                img[y * WIDTH + x] = 200;
            else
                img[y * WIDTH + x] = 50;
        }
    }
    // Add a horizontal bar for horizontal edges
    for (int y = HEIGHT/3; y < HEIGHT/3 + 20; y++)
        for (int x = 0; x < WIDTH; x++)
            img[y * WIDTH + x] = 255;
}

// ---------------------------------------------------------------
// Main testbench
// ---------------------------------------------------------------
int main() {
    static pixel_t src[HEIGHT * WIDTH];
    static pixel_t dst_hls[HEIGHT * WIDTH];
    static pixel_t dst_ref[HEIGHT * WIDTH];

    // 1. Generate test image
    generate_test_image(src);

    // 2. Run HLS function under test
    sobel_filter(src, dst_hls);

    // 3. Run software reference
    sobel_reference(src, dst_ref);

    // 4. Compare
    int err_count = 0;
    for (int i = 0; i < HEIGHT * WIDTH; i++) {
        if (dst_hls[i] != dst_ref[i]) {
            if (err_count < 20) { // print first 20 mismatches
                int y = i / WIDTH;
                int x = i % WIDTH;
                printf("MISMATCH at (%d,%d): HLS=%d  REF=%d\n",
                       x, y, dst_hls[i], dst_ref[i]);
            }
            err_count++;
        }
    }

    // 5. Sanity check -- edges should exist in the output
    int nonzero = 0;
    for (int i = 0; i < HEIGHT * WIDTH; i++)
        if (dst_hls[i] > 0) nonzero++;

    printf("Non-zero output pixels: %d / %d\n", nonzero, HEIGHT * WIDTH);

    if (err_count == 0 && nonzero > 0) {
        printf("TEST PASSED (%d edge pixels detected)\n", nonzero);
        return 0;
    } else {
        printf("TEST FAILED (mismatches=%d, nonzero=%d)\n", err_count, nonzero);
        return 1;
    }
}
