#include "tap.h"

int main () {
    setvbuf(stdout, NULL, _IONBF, 0);
    unsigned char all_0[] = { 0, 0, 0, 0 };
    unsigned char all_255[] = { 255, 255, 255, 255 };
    unsigned char half[] = { 0, 0, 255, 255 };

    plan(4);
    cmp_mem(all_0, all_0, 4, "Array must be equal to itself");
    cmp_mem(all_0, all_255, 4, "Arrays with different contents");
    cmp_mem(all_0, half, 4, "Arrays differ, but start the same");
    cmp_mem(all_0, all_255, 0, "Comparing 0 bytes of different arrays");
    done_testing();
}

