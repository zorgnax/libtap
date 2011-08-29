#include "tap.h"

int main () {
    setvbuf(stdout, NULL, _IONBF, 0);
    plan(5);
    ok(1, "sanity");
    dies_ok({int x = 0; x = x/x;}, "can't divide by zero");
    lives_ok({int x; x = 3/7;}, "this is a perfectly fine statement");
    dies_ok({abort();}, "abort kills the program");
    dies_ok(
        {printf("stdout\n"); fprintf(stderr, "stderr\n"); abort();},
        "supress output");
    done_testing();
}

