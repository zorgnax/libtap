#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 10;
use Test::Differences;

my $x = $^O eq 'MSWin32' ? ".exe" : "";

sub cmd_eq_or_diff {
    my ($command, $expected) = @_;
    my $output = `$command$x 2>&1`;
    eq_or_diff($output, $expected, $command);
}

cmd_eq_or_diff "t/cmpok", <<END;
1..9
not ok 1
#   Failed test at t/cmpok.c line 6.
#     420
#         >
#     666
not ok 2 - the number 23 is definitely 55
#   Failed test 'the number 23 is definitely 55'
#   at t/cmpok.c line 7.
#     23
#         ==
#     55
not ok 3
#   Failed test at t/cmpok.c line 8.
#     23
#         ==
#     55
ok 4
# unrecognized operator 'frob'
not ok 5
#   Failed test at t/cmpok.c line 10.
#     23
#         frob
#     55
ok 6
not ok 7
#   Failed test at t/cmpok.c line 12.
#     55
#         +
#     -55
ok 8
not ok 9
#   Failed test at t/cmpok.c line 14.
#     55
#         %
#     5
# Looks like you failed 6 tests of 9 run.
END

cmd_eq_or_diff "t/cmp_mem", <<END;
1..8
ok 1 - Same array different address
ok 2 - Array must be equal to itself
not ok 3 - Arrays with different contents
#   Failed test 'Arrays with different contents'
#   at t/cmp_mem.c line 13.
#     Difference starts at offset 0
#          got: 0x00
#     expected: 0xff
not ok 4 - Arrays differ, but start the same
#   Failed test 'Arrays differ, but start the same'
#   at t/cmp_mem.c line 14.
#     Difference starts at offset 2
#          got: 0x00
#     expected: 0xff
ok 5 - Comparing 0 bytes of different arrays
not ok 6 - got == NULL
#   Failed test 'got == NULL'
#   at t/cmp_mem.c line 16.
#          got: NULL
#     expected: not NULL
not ok 7 - expected == NULL
#   Failed test 'expected == NULL'
#   at t/cmp_mem.c line 17.
#          got: not NULL
#     expected: NULL
ok 8 - got == expected == NULL
# Looks like you failed 4 tests of 8 run.
END

cmd_eq_or_diff "t/diesok", <<END;
1..5
ok 1 - sanity
ok 2 - can't divide by zero
ok 3 - this is a perfectly fine statement
ok 4 - abort kills the program
ok 5 - supress output
END

cmd_eq_or_diff "t/is", <<END;
1..18
not ok 1 - this is that
#   Failed test 'this is that'
#   at t/is.c line 6.
#          got: 'this'
#     expected: 'that'
ok 2 - this is this
not ok 3
#   Failed test at t/is.c line 8.
#          got: 'this'
#     expected: 'that'
ok 4
ok 5 - null is null
not ok 6 - null is this
#   Failed test 'null is this'
#   at t/is.c line 11.
#          got: '(null)'
#     expected: 'this'
not ok 7 - this is null
#   Failed test 'this is null'
#   at t/is.c line 12.
#          got: 'this'
#     expected: '(null)'
not ok 8
#   Failed test at t/is.c line 13.
#          got: 'foo
# foo
# foo'
#     expected: 'bar
# bar
# bar'
ok 9
ok 10 - this isnt that
not ok 11 - this isnt this
#   Failed test 'this isnt this'
#   at t/is.c line 16.
#          got: 'this'
#     expected: anything else
ok 12
not ok 13
#   Failed test at t/is.c line 18.
#          got: 'this'
#     expected: anything else
not ok 14 - null isnt null
#   Failed test 'null isnt null'
#   at t/is.c line 19.
#          got: '(null)'
#     expected: anything else
ok 15 - null isnt this
ok 16 - this isnt null
ok 17
not ok 18
#   Failed test at t/is.c line 23.
#          got: 'foo
# foo
# foo'
#     expected: anything else
# Looks like you failed 9 tests of 18 run.
END

cmd_eq_or_diff "t/like", <<END;
1..3
ok 1 - strange ~~ /range/
ok 2 - strange !~~ /anger/
ok 3 - matches the regex
END

cmd_eq_or_diff "t/notediag", <<END;
# note no new line
# note new line
# diag no new line
# diag new line
END

cmd_eq_or_diff "t/simple", <<END;
1..24
ok 1
ok 2
ok 3
not ok 4
#   Failed test at t/simple.c line 9.
ok 5 - foo
ok 6 - bar
ok 7 - baz
ok 8 - quux
ok 9 - thud
ok 10 - wombat
ok 11 - blurgle
ok 12 - frob
not ok 13 - frobnicate
#   Failed test 'frobnicate'
#   at t/simple.c line 18.
ok 14 - eek
ok 15 - ook
ok 16 - frodo
ok 17 - bilbo
ok 18 - wubble
ok 19 - flarp
ok 20 - fnord
ok 21
not ok 22
#   Failed test at t/simple.c line 27.
ok 23 - good
not ok 24 - bad
#   Failed test 'bad'
#   at t/simple.c line 29.
# Looks like you failed 4 tests of 24 run.
END

cmd_eq_or_diff "t/skip", <<END;
1..8
ok 1 - quux
ok 2 - thud
ok 3 - wombat
ok 4 # skip need to be on windows
ok 5 - quux
ok 6 - thud
ok 7 - wombat
ok 8 # skip 
END

cmd_eq_or_diff "t/synopsis", <<END;
1..5
ok 1
not ok 2 - two different strings not that way?
#   Failed test 'two different strings not that way?'
#   at t/synopsis.c line 7.
#          got: 'fnord'
#     expected: 'eek'
ok 3 - 3 <= 8732
ok 4
not ok 5
#   Failed test at t/synopsis.c line 10.
#     3
#         >=
#     10
# Looks like you failed 2 tests of 5 run.
END

cmd_eq_or_diff "t/todo", <<END;
1..6
not ok 1 - foo # TODO
#   Failed (TODO) test 'foo'
#   at t/todo.c line 7.
ok 2 - bar # TODO
ok 3 - baz # TODO
not ok 4 - quux # TODO im not ready
#   Failed (TODO) test 'quux'
#   at t/todo.c line 12.
ok 5 - thud # TODO im not ready
ok 6 - wombat # TODO im not ready
END

