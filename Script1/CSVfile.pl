#!usr/bin/perl;

use strict;
use warnings;
use diagnostics;
use Switch;
use Text::CSV_XS;
use Text::Table;
use DBI;

my $sth;
my $file = $ARGV[0] or die "file not loaded\n";
my ( $dsn, $userid, $pass ) =
  ( "DBI:Pg:dbname = rohit ;host = 127.0.0.1;port = 5432", "rohit", "12345" );
my $dbh = DBI->connect( $dsn, $userid, $pass, { RaiseError => 1 } )
  or die $DBI::errstr;

sub display_table {
    my @db;
    my $tb = Text::Table->new(
        \'|    ', "Name",       \'|    ', "DateOfBirth",
        \'|    ', "Department", \'|    ', "DateOfJoining",
        \'|    ', "Salary",     \'|    ', "Email",
        \'     |'
    );
    $sth = $dbh->prepare("select * from Employee_Enquiry;");
    $sth->execute();
    while ( my @row = $sth->fetchrow_array() ) {
        push( @db, \@row );
    }
	$sth->finish();
    $tb->load(@db);
    my $rule = $tb->rule(qw/- +/);
    my @arr  = $tb->body;
    print $rule, $tb->title, $rule;
    for (@arr) {
        print $_. $rule;
    }
}

sub read_file {
    open my $FILE, "<", $file or die "couldn't open $file : $!";
    my $csv = Text::CSV_XS->new( { binary => 1, eol => $/ } );
    $sth = $dbh->prepare("select email from Employee_Enquiry;");
    $sth->execute();
    while ( my $row = $sth->fetchrow_array() ) {
        for ( my $value = $csv->getline($FILE) ) {
            if ( !( ${$value}[5] =~ /$row/ ) ) {
                $sth = $dbh->prepare(
                    "select * from Employee_Enquiry where email=?;");
                $sth->execute($row);
                write_file( join( ",", $sth->fetchrow_array() ) );
            }
        }
    }
    $sth->finish();
    close($FILE) or die "couldn't close reader";
}

sub write_file {
    open my $DATA, ">>", $file or die "couldn't open\n";
    print $DATA "$_[0]\n";
    close $DATA or die "Writer not closed\n";
}

sub insert_details {
    my $sth =
      $dbh->prepare("insert into Employee_Enquiry values (?,?,?,?,?,?)");
    $sth->execute(@_) or die $DBI::errstr;
    $sth->finish();
    print "\nSuccessfully Added\n";
}

sub update_details {
    my $sth = $dbh->prepare(
"update Employee_Enquiry SET name = ?,date_of_birth=?,department=?,date_of_joining=?,salary=? where email=?"
    );
    $sth->execute(@_);
    $sth->finish();
    print "\nSuccessfully Updated\n";
}

sub delete_details {
    my $sth = $dbh->prepare("delete from Employee_Enquiry where email=?");
    $sth->execute( $_[0] );
    $sth->finish();
    print "\nSuccessfully Deleted\n";
}

sub new_details {
    print "\n::::Details of the Empolyee ::::\n";
    my $email = $_[0];

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
    return 0 if ( &number_validation($salary) == -1 );

    my @newrecord = ( $name, $dOb, $dept, $doj, $salary, $email );
    return @newrecord;
}

sub number_validation {
    my $data   = $_[0];
    my $number = $data =~ /^[0-9]+$/;
    if ( not $number ) {
        print "Invalid Salary :: no comma's allowed";
        return -1;
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

sub email_validation {
    print "Enter Email_ID ::\n";
    chomp( my $email = <STDIN> );
    my $regex =
      $email =~ /^[a-z0-9A-Z]([a-z0-9A-Z.]+[a-z0-9A-Z])?\@[a-zA-Z0-9.-]+$/;
    if ( not $regex ) {
        print "Invalid Email_ID\n";
        return -1;
    }
    $sth = $dbh->prepare("select Email from Employee_Enquiry where Email=?");
    $sth->execute($email);
    if ( $sth->rows == 1 ) {
        if ( $_[0] == 3 ) { delete_details($email); }
        if ( $_[0] == 2 ) { update_details( new_details($email) ); }
    }
    else {
        print "\n insert \n";
        insert_details( new_details($email) );
    }
    $sth->finish();
}

display_table();
while (1) {
    print
"\n  1::Add employee\n  2::Edit employee\n  3::Delete Employee\n  4::List Of Employee\n\n Any other key to STOP\n Option-> \t";
    chomp( my $val = <STDIN> );
    switch ($val) {
        case 1 {
            email_validation($val);
        }
        case 2 {
            email_validation($val);
        }
        case 3 {
            email_validation($val);
        }
        case 4 {
            display_table();
        }
        else { $val = 0; }
    }
    if ( $val == 0 ) { last; }
}
read_file();
$dbh->disconnect();
