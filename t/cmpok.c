#include "tap.h"

int main () {
    setvbuf(stdout, NULL, _IONBF, 0);
    plan(9);
    cmp_ok(420, ">", 666);
    cmp_ok(23, "==", 55, "the number 23 is definitely 55");
    cmp_ok(23, "==", 55);
    cmp_ok(23, "!=", 55);
    cmp_ok(23, "frob", 55);
    cmp_ok(23, "<=", 55);
    cmp_ok(55, "+", -55);
    cmp_ok(23, "%", 5);
    cmp_ok(55, "%", 5);
    done_testing();
}

