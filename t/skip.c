#include "tap.h"

int main () {
    setvbuf(stdout, NULL, _IONBF, 0);
    plan(8);
    skip(0, 3, "%s cannot fork", "windows");
    ok(1, "quux");
    ok(1, "thud");
    ok(1, "wombat");
    endskip;
    skip(1, 1, "need to be on windows");
    ok(0, "blurgle");
    endskip;
    skip(0, 3);
    ok(1, "quux");
    ok(1, "thud");
    ok(1, "wombat");
    endskip;
    skip(1, 1);
    ok(0, "blurgle");
    endskip;
    done_testing();
}

