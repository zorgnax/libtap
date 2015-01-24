#!/usr/bin/perl
use strict;
use warnings;
use Test::More;

my $x = $^O eq 'MSWin32' ? ".exe" : "";

for my $cfile (glob "t/*.c") {
    $cfile =~ m{([^/]+)\.c$};
    my $name = $1;
    my $output = `t/$name$x 2>&1`;
    open my $fh, ">", "t/$name.got" or die "Can't open t/$name.got: $!\n";
    print $fh $output;
    close $fh;
    system "diff", "-up", "t/$name.expected", "t/$name.got";
    ok !($? >> 8), $name;
}

done_testing;
