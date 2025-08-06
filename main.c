#include <stdint.h>

#define REG_DISPCNT *(volatile uint32_t*)0x4000000
#define MODE3 0x0003
#define BG2_ENABLE 0x0400

#define VIDEO_BUFFER ((volatile uint16_t*)0x6000000)
#define RGB15(r,g,b) ((r) | ((g) << 5) | ((b) << 10))

#define KEY_INPUT *(volatile uint16_t*)0x4000130
#define KEY_MASK 0x03FF

enum {
    KEY_A      = 1 << 0,
    KEY_B      = 1 << 1,
    KEY_SELECT = 1 << 2,
    KEY_START  = 1 << 3,
    KEY_RIGHT  = 1 << 4,
    KEY_LEFT   = 1 << 5,
    KEY_UP     = 1 << 6,
    KEY_DOWN   = 1 << 7,
    KEY_R      = 1 << 8,
    KEY_L      = 1 << 9,
};

static inline uint16_t keys_pressed() {
    return ~KEY_INPUT & KEY_MASK;
}

static void set_pixel(int x, int y, uint16_t color) {
    VIDEO_BUFFER[y * 240 + x] = color;
}

void main() {
    REG_DISPCNT = MODE3 | BG2_ENABLE;

    int x = 120, y = 80;

    while (1) {
        set_pixel(x, y, 0); // Clear previous pixel

        uint16_t keys = keys_pressed();

        if (keys & KEY_LEFT && x > 0) x--;
        if (keys & KEY_RIGHT && x < 239) x++;
        if (keys & KEY_UP && y > 0) y--;
        if (keys & KEY_DOWN && y < 159) y++;

        set_pixel(x, y, RGB15(31, 0, 0)); // Draw red pixel
    }
}
