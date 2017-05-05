#!usr/bin/perl;

use strict;
use warnings;
use diagnostics;
use Switch;
use Text::CSV_XS ();
use Text::Table ();
use DBI ();

my $sth;
my $file = $ARGV[0] or die "file not loaded\n";
my ( $dsn, $userid, $pass ) =
  ( "DBI:Pg:dbname = rohit ;host = 127.0.0.1;port = 5432", "rohit", "12345" );
my $dbh = DBI->connect( $dsn, $userid, $pass, { RaiseError => 1 } )
  or die $DBI::errstr;
my %build;

sub display_table {
	my @db;
    my $tb = Text::Table->new(
        \'|    ', "Name",       \'|    ', "DateOfBirth",
        \'|    ', "Department", \'|    ', "DateOfJoining",
        \'|    ', "Salary",     \'|    ', "Email",
        \'     |'
    );
	foreach my $v (values %build){
	  push (@db ,$v);
	}
    $tb->load(@db);
    my $rule = $tb->rule(qw/- +/);
    my @arr  = $tb->body;
    print $rule, $tb->title, $rule;
   print $_. $rule for @arr;
}

sub query_database {
    $sth = $dbh->prepare("select * from Employee_Enquiry;");
    $sth->execute() or die $DBI::errstr;
    while ( my @row = $sth->fetchrow_array() ) {
        $build{$row[5]} = \@row;
   }
}

sub read_file {
    open my $FILE, "<", $file or die "couldn't open $file : $!";
    my $csv = Text::CSV_XS->new( { binary => 1, eol => $/ } );
    while ( my $value = $csv->getline($FILE) ) {
        unless( defined $build{$value->[5]}  ) {
            &insert_details($value);  ####################################
			$build{$value->[5]} = $value;
		}
	}
 close $FILE or die "couldn't close reader";
}

sub write_file {
    open my $DATA, ">", $file or die "couldn't open\n";
    foreach (keys %build){
    	print $DATA join(',',@{$build{$_}}),"\n";
  }
    close $DATA or die "Writer not closed\n";
}

sub insert_details {
    my @data = @_;
    $sth = $dbh->prepare("insert into Employee_Enquiry values (?,?,?,?,?,?)");
    $build{$data[5]} = \@data;
	$sth->execute(@data) or die $DBI::errstr;
    $sth->finish();
    print "\nSuccessfully Added\n";
}

sub update_details {
	my @data=@_;
    $sth = $dbh->prepare(
"update Employee_Enquiry SET name = ?,date_of_birth=?,department=?,date_of_joining=?,salary=? where email=?"
    );
    $build{$data[5]} = \@data;
	$sth->execute(@data);
    $sth->finish();
    print "\nSuccessfully Updated\n";
}

sub delete_details {
	my $data = $_[0];
    $sth = $dbh->prepare("delete from Employee_Enquiry where email=?");
     delete $build{$data} ;
    $sth->execute( $data );
    $sth->finish();
    print "\nSuccessfully Deleted\n";
}

sub new_details {
	my ($email,$dob,$doj,$dept,$salary,$name);
LINE:while(1){
	print "\n::::Details of the Empolyee ::::\n";
    $email = $_[0];

    print "Enter the Name of Employee :: ";
    chomp(  $name = <STDIN> );
    redo LINE if ( &string_validation($name) == 0 );

    print "Enter the DOB of Employee :: 'Ex-> 1994-01-01'\t ";
    chomp(  $dob = <STDIN> );
    redo LINE if ( &date_validation($dob) == 0 );

    print "Enter the Department of Employee ::\t ";
    chomp(  $dept = <STDIN> );
    redo LINE if ( &string_validation($dept) == 0 );

    print "Enter the DOJ of Employee :: 'Ex-> 1994-01-01' \t ";
    chomp(  $doj = <STDIN> );
    redo LINE if ( &date_validation($doj) == 0 );

    print "Enter the Salary of Employee ::\t ";
    chomp(  $salary = <STDIN> );
    redo LINE if ( &number_validation($salary) == 0 );
    last;
 }
    my @newrecord = ( $name, $dob, $dept, $doj, $salary, $email );
    return @newrecord;
}

sub number_validation {
    my $data   = $_[0];
    my $number = $data =~ /^[0-9]+$/;
    if ( not $number ) {
        print "Invalid Salary :: no comma's allowed";
        return 0;
    }
}

sub string_validation {
    my $data   = $_[0];
    my $string = $data =~ /^[a-zA-Z _]+$/;
    if ( not $string ) {
        print "Invalid Detail \n";
        return 0;
    }
}

sub date_validation {
    my $data = $_[0];
    my $date =
      $data =~ /^(19|20)\d\d-(0[1-9]|1[0-2])-(0[0-9]|[12][0-9]|3[01])$/;
    if ( not $date ) {
        print "Invalid Date yyyy-mm-dd\n ";
        return 0;
    }
}

sub email_validation {
	my $val = shift;
    print "Enter Email_ID ::\n";
    chomp( my $email = <STDIN> );
    my $regex =
      $email =~ /^[a-z0-9A-Z]([a-z0-9A-Z.]+[a-z0-9A-Z]).@[a-zA-Z0-9.-]+$/;
    if ( not $regex ) {
        print "Invalid Email_ID\n";
        return 0;
    }
    $sth = $dbh->prepare("select Email from Employee_Enquiry where Email=?");
    $sth->execute($email);
    if ( $sth->rows == 1 ) {
         delete_details($email) if $val==3;
       update_details( new_details($email)) if $val==2;
	   print "CHOOSE a better option--Adding Email that Already Exists--" if $val==1;
    }
    else {
        insert_details( new_details($email) );
    }
    $sth->finish();
}

query_database();
read_file();
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

write_file();
$dbh->disconnect();
