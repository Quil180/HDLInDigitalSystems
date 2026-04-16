#ifndef SOBEL_H
#define SOBEL_H

#define WIDTH  256
#define HEIGHT 256

typedef unsigned char pixel_t;

void sobel_filter(pixel_t *src, pixel_t *dst);

#endif // SOBEL_H
