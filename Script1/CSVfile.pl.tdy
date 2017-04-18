#!usr/bin/perl;

use strict;
use warnings;
use diagnostics;
use Switch;
use Text::CSV_XS;
use Text::Table;

my %hash;
my @db;
my $file = $ARGV[0] or die "file not loaded\n";

sub csv_to_table {
    open my $FILE, "<", $file or die "couldn't open $file : $!";
    my $csv = Text::CSV_XS->new( { binary => 1, eol => $/ } );
    while ( my $value = $csv->getline($FILE) ) {
        push( @db, $value );
    }
    close($FILE) or die "couldn't close CSVreader";

    my $tb = Text::Table->new(
        \'| ', "Name",       \'| ', "DateOfBirth",
        \'| ', "Department", \'| ', "DateOfJoining",
        \'| ', "Salary",     \'| ', "Email",
        \'     |'
    );
    $tb->load(@db);
    my $rule = $tb->rule(qw/- +/);
    my @arr  = $tb->body;
    print $rule, $tb->title, $rule;
    for (@arr) {
        print $_. $rule;
    }
}

sub new_employee {
    print "\n::::Details of the Empolyee ::::\n";
    my $Email = $_[0];
    my $val   = $_[1];

    print "Enter the Name of Employee :: ";
    chomp( my $name = <STDIN> );
    return 0 if ( &string_validation($name) == -1 );

    print "Enter the DOB of Employee :: 'Ex-> 01Jan1994'\t ";
    chomp( my $dOb = <STDIN> );
    return 0 if ( &date_validation($dOb) == -1 );

    print "Enter the Department of Employee ::\t ";
    chomp( my $dept = <STDIN> );
    return 0 if ( &string_validation($dept) == -1 );

    print "Enter the DOJ of Employee :: 'Ex-> 01Jan1994' \t ";
    chomp( my $doj = <STDIN> );
    return 0 if ( &date_validation($doj) == -1 );

    print "Enter the Salary of Employee ::\t ";
    chomp( my $salary = <STDIN> );

    my @newrecord = ( $name, $dOb, $dept, $doj, "$salary", $Email );
    if ( $val == 1 ) {
        my $new = \@newrecord;
        $db[ $#db + 1 ] = $new;
        $hash{$Email} = $#db + 1;
    }
    if ( $val == 2 ) {
        my $new = \@newrecord;
        return $new;
    }
}

sub string_validation {
    my $data   = $_[0];
    my $string = $data =~ /^[a-zA-Z _]+$/;
    if ( not $string ) {
        print "Invalid Detail \n";
        return -1;
    }
}

sub date_validation {
    my $data = $_[0];
    my $date = $data =~
/^(0[1-9]|[12][0-9]|3[01])(jan|feb|mar|apr|may|jun|jul|aug|sep|oct|nov|dec|Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)(19|20)\d\d$/;
    if ( not $date ) {
        print "Invalid Date dd/[jan-dec]/yyyy\n ";
        return -1;
    }
}

sub writer {
    open my $DATA, ">", $file or die "couldn't open";
    foreach my $v (@db) {
        if ( defined $v ) {
            my @record = @{$v};
            $record[4] = '"' . $record[4] . '"';
            my $string = join( ',', @record );
            @record = ();
            print $DATA "$string\n";
        }
    }
    close $DATA or die "Writer not closed";
}

sub validate_data {
    my $val = $_[0];
    print "Enter Email_ID for validation ::\n";
    chomp( my $Email = <STDIN> );
    my $regex =
      $Email =~ /^[a-z0-9A-Z]([a-z0-9A-Z.]+[a-z0-9A-Z])?\@[a-zA-Z0-9.-]+$/;
    if ( not $regex ) {
        print "Invalid Email_ID";
        return 0;
    }
    if ( exists $hash{$Email} ) {
        print "Already available try a NEW Record\n";
        if ( $val == 3 ) {
            $db[ $hash{$Email} ] = undef;
            delete $hash{$Email};
            print "DONE!";
            return 0;
        }
        if ( $val == 2 ) {
            my $new = new_employee( $Email, $val );
            if ( $new == 0 ) { return 0; }
            $db[ $hash{$Email} ] = $new;
            print "DONE!";
            return 0;
        }
    }
    else { print "New Record!"; new_employee( $Email, $val ); }
}

csv_to_table();
for my $v ( 0 .. $#db ) {
    $hash{ ${ $db[$v] }[5] } = $v;
}
while (1) {
    print
"\n  1::Add employee\n  2::Edit employee\n  3::Delete Employee\n\n Any other key to STOP\n Option-> \t";
    chomp( my $val = <STDIN> );
    switch ($val) {
        case 1 {
            print "$val\n";
            validate_data($val);
        }
        case 2 {
            print "$val\n";
            validate_data($val);
        }
        case 3 {
            print "$val\n";
            validate_data($val);
        }
        else { $val = 0; }
    }
    if ( $val == 0 ) { last; }
}
writer();
@db = ();
csv_to_table();
