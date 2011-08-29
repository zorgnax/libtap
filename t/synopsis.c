#include "tap.h"

int   foo () {return 3;}
char *bar () {return "fnord";}

int main () {
    setvbuf(stdout, NULL, _IONBF, 0);
    plan(5);
    ok(foo() == 3);
    is(bar(), "eek");
    ok(foo() <= 8732, "foo <= %d", 8732);
    like(bar(), "f(yes|no)r*[a-f]$", "is like");
    cmp_ok(foo(), ">=", 10, "foo is greater than ten");
    done_testing();
}

