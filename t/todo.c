#include "tap.h"

int main () {
    setvbuf(stdout, NULL, _IONBF, 0);
    plan(6);
    todo();
    ok(0, "foo");
    ok(1, "bar");
    ok(1, "baz");
    endtodo;
    todo("im not ready");
    ok(0, "quux");
    ok(1, "thud");
    ok(1, "wombat");
    endtodo;
    done_testing();
}

