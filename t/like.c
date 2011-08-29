#include "tap.h"

int main () {
    setvbuf(stdout, NULL, _IONBF, 0);
    plan(3);
    like("strange", "range", "strange ~~ /range/");
    unlike("strange", "anger", "strange !~~ /anger/");
    like("stranger", "^s.(r).*\\1$", "matches the regex");
    done_testing();
}

