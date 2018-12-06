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
get '/my.cnf' => sub {
    my $content = read_file( "/etc/my.cnf" );
    template 'raw', { content=>$content };
};

true;
