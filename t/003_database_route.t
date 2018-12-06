use Test::More tests => 4;
use strict;
use warnings;
use File::Slurp::Tiny qw(read_file);

# the order is important
use DancerDBTest;
use Dancer::Test;

route_exists [GET => '/database'], 'a route handler is defined for /database';
response_status_is ['GET' => '/database'], 200, 'response status is 200 for /database';

# response_content_like([$method, $path], $regexp, $test_name)
response_content_like( ['GET' => '/database'], qr{connected to test}, "connected to 'test' database" );
response_content_like( ['GET' => '/my.cnf'], qr{mysqld}, "my.cnf contains 'mysqld'" );
my $content = read_file( "/etc/my.cnf" );
diag( "content: $content" );

