package DancerDBTest;
use Dancer::Plugin::Database;
use Dancer ':syntax';

use File::Slurp::Tiny qw(read_file);

our $VERSION = '0.1';

get '/' => sub {
    template 'index';
};

get '/database' => sub {
    my $dbname = database()->selectrow_array( "select database()" );
    template 'raw', { content=>"HI, connected to $dbname" };
};

get '/database_with_timeout' => sub {
    my $dbh = database();
    my ($dbname1, $dbname2);
    {
        $dbname1 = $dbh->selectrow_array( "/* before sleep */ select database()" );
    }

    sleep(3);

    {
        $dbname2 = $dbh->selectrow_array( "/* after sleep */ select database()" );
        # on centos7 with mariadb we get 'MySQL server has gone away' here
    }
    template 'raw', { content=> "dbname1: $dbname1, dbname2: $dbname2" };
};

get '/my.cnf' => sub {
    my $content = '';

    Try::Tiny::try{ 
        $content = read_file( "/etc/my.cnf" ); 
    } Try::Tiny::catch sub {
    };

    unless($content) {
        Try::Tiny::try{ $content = read_file( "/etc/mysql/my.cnf" ); } 
        Try::Tiny::catch sub {
        };
    }
    
    template 'raw', { content=>$content };
};

true;
