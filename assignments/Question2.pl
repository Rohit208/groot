#! usr/bin/perl;

#Write a program to implement command line arguments like opening and closing  
#a file and enter text in file and display content with statistics.


use strict;
use warnings;
use diagnostics;

my $file1 = $ARGV[0];

sub Reader{
	open my $FILLER,'<',$file1 or die "can't open $file1";
	while(my $info = <$FILLER>){
		chomp($info);
		print $info;
	}	
close $FILLER or die  "couldn't close";
}

sub Writer{
	my $text = <STDIN>;
	open my $FILLER,'>>',$file1 or die "can't open $file1";
	print $FILLER "$text";
	close $FILLER or die "Couldn't close";
}


Writer();
Reader();
