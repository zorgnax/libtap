/* test 1: very simple usage of the library. Doesnt produce test output
(There are failures), but shows how it can be used.  */

#include "../tap.h"

int main () {
    plan(20);
    
    ok(1);
    ok(1);
    ok(1);
    ok(0);
    ok(1, "foo");
    ok(1, "bar");
    ok(1, "baz");
    ok(1, "quux");
    ok(1, "thud");
    ok(1, "wombat");
    ok(1, "blurgle");
    ok(1, "frob");
    ok(0, "frobnicate");
    ok(1, "eek");
    ok(1, "ook");
    ok(1, "frodo");
    ok(1, "bilbo");
    ok(1, "wubble");
    ok(1, "flarp");
    ok(1, "fnord");

    return exit_status();
}

