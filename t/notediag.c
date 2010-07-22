#include "tap.h"

int main () {
    setvbuf(stdout, NULL, _IONBF, 0);
    note("note no new line");    
    note("note new line\n");
    note("");
    note(NULL);
    diag("diag no new line");    
    diag("diag new line\n");
    diag("");
    diag(NULL);
    return 1;
}

