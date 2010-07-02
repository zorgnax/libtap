#include "../tap.h"

int main () {
    plan(11);
    
    ok(1, "foo");
    ok(1, "bar");
    ok(1, "baz");
    
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

    return exit_status();
}

