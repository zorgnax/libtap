#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <sys/mman.h>
#include "tap.h"

static int expected_tests = NO_PLAN;
static int failed_tests;
static int current_test;

void plan (int tests) {
    expected_tests = tests;
    if (tests != NO_PLAN)
        printf("1..%d\n", tests);
}

int ok_at_loc (const char *file, int line, int test, const char *fmt, ...) {
    va_list args;
    char *name = "";
    
    if (fmt) {
        va_start(args, fmt);
        vasprintf(&name, fmt, args);
        va_end(args);
    }
    
    printf("%sok %d%s%s\n",
        test ? "" : "not ",
        ++current_test,
        *name ? " - " : "",
        name);
    
    if (!test) {
        if (*name)
            diag("  Failed test '%s'\n  at %s line %d.", name, file, line);
        else
            diag("  Failed test at %s line %d.", file, line);
        failed_tests++;
    }
    
    if (fmt) free(name);

    return test;
}

static void diag_to_fh_v (FILE *fh, const char *fmt, va_list args) {
    char *mesg, *line;
    int i;

    if (!fmt) return;
    vasprintf(&mesg, fmt, args);
    
    line = mesg;
    for (i = 0; *line; i++) {
        char c = mesg[i];
        if (!c || c == '\n') {
            mesg[i] = '\0';
            fprintf(fh, "# %s\n", line);
            if (!c) break;
            mesg[i] = c;
            line = &mesg[i+1];
        }
    }
    
    free(mesg);
    
    return;
}

int diag (const char *fmt, ...) {
    va_list args;
    va_start(args, fmt);
    diag_to_fh_v(stderr, fmt, args);
    va_end(args);
    return 1;
}

int note (const char *fmt, ...) {
    va_list args;
    va_start(args, fmt);
    diag_to_fh_v(stdout, fmt, args);
    va_end(args);
    return 1;
}

int exit_status () {
    int retval = EXIT_SUCCESS;
    if (expected_tests == NO_PLAN) {
        printf("1..%d\n", current_test);
    }
    else if (current_test != expected_tests) {
        diag("Looks like you planned %d test%s but ran %d.",
            expected_tests, expected_tests > 1 ? "s" : "", current_test);
        retval = EXIT_FAILURE;
    }
    if (failed_tests) {
        diag("Looks like you failed %d test%s of %d run.",
            failed_tests, failed_tests > 1 ? "s" : "", current_test);
        retval = EXIT_FAILURE;
    }
    return retval;
}

/* Create a shared memory int to keep track of whether a piece of code 
executed dies. to be used in the dies_ok and lives_ok macros  */
int tap_test_died (int b) {
    static int *test_died = NULL;
    
    if (!test_died) {
        test_died = mmap(0, sizeof (int), PROT_READ | PROT_WRITE,
                         MAP_SHARED | MAP_ANONYMOUS, -1, 0);
    }
    
    int prev = *test_died;
    *test_died = b;
    return prev;
}

