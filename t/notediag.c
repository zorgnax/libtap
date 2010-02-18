/* test3 make sure that note and diag are giving correct output  */

#include "../tap.h"

int main () {
    
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

