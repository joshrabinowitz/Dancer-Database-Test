package DancerDBTest;
use Dancer::Plugin::Database;
use Dancer ':syntax';

our $VERSION = '0.1';

get '/' => sub {
    template 'index';
};

get '/database' => sub {
    my $dbname = database()->selectrow_array( "select database()" );
    template 'raw', { content=>"HI, connected to $dbname" };

};

true;
