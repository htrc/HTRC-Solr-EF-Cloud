#!/usr/bin/perl 

use strict;
use warnings;

my $ARGC=scalar(@ARGV);

if ($ARGC != 2) {
    print STDERR "Usage: $0 filename-file.txt filesize-file.txt\n";
    exit 1;
}

my $filename_filename = $ARGV[0];
my $filesize_filename = $ARGV[1];

open my $fnin, $filename_filename or die "Could not open $filename_filename: $!";
open my $fsin, $filesize_filename or die "Could not open $filesize_filename: $!";

my $subdir_total = {};

my $line_counter = 1;

my $flag_error = 0;
my $prev_subdir = "";

while (1) {
    my $fn_line = <$fnin>;
    my $fs_line = <$fsin>;

    if (defined $fn_line && ($fn_line ne "")) {
	if (defined $fs_line && ($fs_line ne "")) {
	    # process the pair

	    my ($top_level,$subdir,$rest) = ($fn_line =~ m/(.*?)\.(..)(.*)/);

	    chomp($fs_line);

	    # print "$top_level: $subdir $rest -> $fs_line\n";   

	    if ($subdir ne $prev_subdir) {
		print "Processing $subdir\n";
	    }

	    $subdir_total->{$subdir} += $fs_line;

	    $prev_subdir = $subdir;

 	}
	else {
	    chomp $fn_line;
	    print STDERR "Error on line $line_counter: there was no matching file-size for file-name $fn_line\n";
	    $flag_error = 1;
	    last;
	}
    }
    else {
	if (defined $fs_line) {
	    chomp $fs_line;
	    print STDERR "Error on line $line_counter: there was no matching file-name for file-size $fs_line\n";
	    print STDERR "Sub-directory level being processed: $prev_subdir\n";
	    $flag_error = 1;
	    last;
	}
	else {
	    # Both not defined => correctc criteria for stopping
	    last;
	}
    }

    $line_counter++;
}

for my $key (sort keys %$subdir_total) {
    my $val = $subdir_total->{$key};
    print "$val $key\n";
}

if ($flag_error) {
    print STDERR "***** Warning: due to error in processing, subdirectory filesize calculation incomplete\n";
}

close $fnin;
close $fsin;
