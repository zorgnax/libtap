#define USE_AUTO_PLAN
#include "tap.h"

void test_everything () {
    char buf1[4] = { 0, 1, 2, 3 };
    char buf2[4] = { 0, 1, 2, 3 };

    cmp_ok(1, "==", 1, "cmp_ok");
    ok(1, "ok");
    is("abc", "abc", "is");
    isnt("abc", "foo", "isnt");
    cmp_mem(buf1, buf2, sizeof(buf1), "cmp_mem");
    like("fnord", "f(yes|no)r*[a-f]$", "like");
}

int main () {
    plan(AUTO_PLAN);
    test_everything();
    done_testing();
}
