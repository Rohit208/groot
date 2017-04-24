#!usr/bin/perl;

use strict;
use warnings;
use diagnostics;
use Switch;
use Text::CSV_XS;
use Text::Table;
use DBI;

my %hash;
my @db;
my $file = $ARGV[0] or die "file not loaded\n";

sub read_file {
    open my $FILE, "<", $file or die "couldn't open $file : $!";
    my $csv = Text::CSV_XS->new( { binary => 1, eol => $/ } );
    while ( my $value = $csv->getline($FILE) ) {
        push( @db, $value );
    }
    close($FILE) or die "couldn't close reader";
}

sub display_table {
    my $tb = Text::Table->new(
        \'|    ', "Name",       \'|    ', "DateOfBirth",
        \'|    ', "Department", \'|    ', "DateOfJoining",
        \'|    ', "Salary",     \'|    ', "Email",
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

sub Insert_Database {
    my $driver   = "Pg";
    my $database = "rohit";
    my $dsn    = "DBI:$driver:dbname = $database;host = 127.0.0.1;port = 5432";
    my $userid = "rohit";
    my $pass   = "12345";
    my $dbh    = DBI->connect( $dsn, $userid, $pass, { RaiseError => 1 } )
      or die $DBI::errstr;

    foreach (@db) {
        if ( defined $_ ) {
            my @val = @{$_};
            for ( my $i = 0 ; $i <= $#val ; $i++ ) {
                if ( $i == 4 ) { next; }
                $val[$i] = '\'' . $val[$i] . '\'';
            }
            my $string = join( ",", @val );
            my $stmt   = "insert into Employee_Enquiry values ($string)";
            my $rv     = $dbh->do($stmt) or die $DBI::errstr;
        }
    }
    print "\nSuccessfully updated database\n";
    $dbh->disconnect();
}

sub new_employee {
    print "\n::::Details of the Empolyee ::::\n";
    my $Email = $_[0];
    my $val   = $_[1];

    print "Enter the Name of Employee :: ";
    chomp( my $name = <STDIN> );
    return 0 if ( &string_validation($name) == -1 );

    print "Enter the DOB of Employee :: 'Ex-> 1994-01-01'\t ";
    chomp( my $dOb = <STDIN> );
    return 0 if ( &date_validation($dOb) == -1 );

    print "Enter the Department of Employee ::\t ";
    chomp( my $dept = <STDIN> );
    return 0 if ( &string_validation($dept) == -1 );

    print "Enter the DOJ of Employee :: 'Ex-> 1994-01-01' \t ";
    chomp( my $doj = <STDIN> );
    return 0 if ( &date_validation($doj) == -1 );

    print "Enter the Salary of Employee ::\t ";
    chomp( my $salary = <STDIN> );

    my @newrecord = ( $name, $dOb, $dept, $doj, "$salary", $Email );
    if ( $val == 1 ) {
        my $new = \@newrecord;
        $db[ $#db + 1 ] = $new;
        $hash{$Email} = $#db;
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
    my $date =
      $data =~ /^(19|20)\d\d-(0[1-9]|1[0-2])-(0[0-9]|[12][0-9]|3[01])$/;
    if ( not $date ) {
        print "Invalid Date yyyy-mm-dd\n ";
        return -1;
    }
}

sub write_file {
    open my $DATA, ">", $file or die "couldn't open\n";
    foreach my $v (@db) {
        if ( defined $v ) {
            my @record = @{$v};
            my $string = join( ',', @record );
            @record = ();
            print $DATA "$string\n";
        }
    }
    close $DATA or die "Writer not closed\n";
}

sub validate_data {
    my $val = $_[0];
    print "Enter Email_ID for validation ::\n";
    chomp( my $Email = <STDIN> );
    my $regex =
      $Email =~ /^[a-z0-9A-Z]([a-z0-9A-Z.]+[a-z0-9A-Z])?\@[a-zA-Z0-9.-]+$/;
    if ( not $regex ) {
        print "Invalid Email_ID\n";
        return 0;
    }
    if ( exists $hash{$Email} ) {
        print "Already available try a NEW Record\n";
        if ( $val == 3 ) {
            $db[ $hash{$Email} ] = undef;
            delete $hash{$Email};
            print "DONE!\n";
            return 0;
        }
        if ( $val == 2 ) {
            my $new = new_employee( $Email, $val );
            if ( $new == 0 ) { return 0; }
            $db[ $hash{$Email} ] = $new;
            print "DONE!\n";
            return 0;
        }
    }
    else {
        if ( $val == 3 or $val == 2 ) {
            print "Email not Available\n";
            return 0;
        }
        print "New Record!";
        new_employee( $Email, $val );
    }
}

read_file();
display_table();
for my $v ( 0 .. $#db ) {
    $hash{ ${ $db[$v] }[5] } = $v;
}
while (1) {
    print
"\n  1::Add employee\n  2::Edit employee\n  3::Delete Employee\n  4::List Of Employee\n\n Any other key to STOP\n Option-> \t";
    chomp( my $val = <STDIN> );
    switch ($val) {
        case 1 {
            validate_data($val);
        }
        case 2 {
            validate_data($val);
        }
        case 3 {
            validate_data($val);
        }
        case 4 {
            display_table();
        }
        else { $val = 0; }
    }
    if ( $val == 0 ) { last; }
}
write_file();
display_table();
Insert_Database();
