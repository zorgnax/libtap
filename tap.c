#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include "tap.h"

static int expected_tests = NO_PLAN;
static int failed_tests;
static int current_test;
static char *todo_mesg = NULL;

void plan (int tests) {
    expected_tests = tests;
    if (tests != NO_PLAN)
        printf("1..%d\n", tests);
}

static char *vstrdupf (const char *fmt, va_list args) {
    char *str;
    int size = vsnprintf(NULL, 0, fmt, args) + 1;
    str = malloc(size);
    vsprintf(str, fmt, args);
    return str;
}

int ok_at_loc (const char *file, int line, int test, const char *fmt, ...) {
    va_list args;
    char *name = "";
    if (fmt) {
        va_start(args, fmt);
        name = vstrdupf(fmt, args);
        va_end(args);
    }
    printf("%sok %d", test ? "" : "not ", ++current_test);
    if (*name)
        printf(" - %s", name);
    if (todo_mesg) {
        printf(" # TODO");
        if (*todo_mesg)
            printf(" %s", todo_mesg);
    }
    printf("\n");
    if (!test) {
        if (*name)
            diag("  Failed%s test '%s'\n  at %s line %d.",
                todo_mesg ? " (TODO)" : "", name, file, line);
        else
            diag("  Failed%s test at %s line %d.",
                todo_mesg ? " (TODO)" : "", file, line);
        if (!todo_mesg)
            failed_tests++;
    }
    if (fmt)
        free(name);
    return test;
}

static void vdiag_to_fh (FILE *fh, const char *fmt, va_list args) {
    char *mesg, *line;
    int i;
    if (!fmt)
        return;
    mesg = vstrdupf(fmt, args);
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
    vdiag_to_fh(stderr, fmt, args);
    va_end(args);
    return 1;
}

int note (const char *fmt, ...) {
    va_list args;
    va_start(args, fmt);
    vdiag_to_fh(stdout, fmt, args);
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

void skippy (int n, const char *fmt, ...) {
    char *why;
    va_list args;
    va_start(args, fmt);
    why = vstrdupf(fmt, args);
    va_end(args);
    while (n --> 0) {
        printf("ok %d ", ++current_test);
        note("skip %s\n", why);
    }
    free(why);
}

void ctodo (int ignore, const char *fmt, ...) {
    va_list args;
    va_start(args, fmt);
    todo_mesg = vstrdupf(fmt, args);
    va_end(args);
}

void cendtodo () {
    free(todo_mesg);
    todo_mesg = NULL;
}

#ifndef _WIN32
#   include <sys/mman.h>
    /* Create a shared memory int to keep track of whether a piece of code 
    executed dies. to be used in the dies_ok and lives_ok macros  */
    int tap_test_died (int status) {
        static int *test_died = NULL;
        int prev;
        if (!test_died) {
            test_died = mmap(0, sizeof (int), PROT_READ | PROT_WRITE,
                             MAP_SHARED | MAP_ANONYMOUS, -1, 0);
            *test_died = 0;
        }
        prev = *test_died;
        *test_died = status;
        return prev;
    }
#endif

