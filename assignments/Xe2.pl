
    use strict;
    use warnings;
    my $name = 'foo';
    print qq(The (name) is "$name"\n);

    print qq(The "name" is "$name"\n);

    #print qq(The )name( is "$name"\n);   #syntax error as ther must be same no. of opening and closing parenthesis.

    print qq{The )name( is "$name"\n};   # qq is a operator and can change the {..} parenthesis format. 

    print q[The )name} is "$name"\n];   # it doesn't interpolate..
    
