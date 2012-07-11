#include "tap.h"

int main () {
    setvbuf(stdout, NULL, _IONBF, 0);
    plan(5);
    ok(3 == 3);
    is("fnord", "eek", "two different strings not that way?");
    ok(3 <= 8732, "%d <= %d", 3, 8732);
    like("fnord", "f(yes|no)r*[a-f]$");
    cmp_ok(3, ">=", 10);
    done_testing();
}

