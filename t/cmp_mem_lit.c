#include "tap.h"

int main () {
    setvbuf(stdout, NULL, _IONBF, 0);
    unsigned char arr[] = { 0, 0, 0xff, 0xff };

    plan(5);
    cmp_mem_lit(arr, (0, 0, 0xff, 0xff));   /* no description */
    cmp_mem_lit(arr, (0, 0, 0xff, 0xff), "Match");
    cmp_mem_lit(arr, (1, 2, 3), "Completely different");
    cmp_mem_lit(arr, (0, 0, 1, 1), "Different from 3rd byte");
    cmp_mem_lit(NULL, (0), "got == NULL");
    done_testing();
}

