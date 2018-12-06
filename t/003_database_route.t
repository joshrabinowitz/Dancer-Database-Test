use Test::More tests => 6;
use strict;
use warnings;

# the order is important
use DancerDBTest;
use Dancer::Test;

route_exists [GET => '/database'], 'a route handler is defined for /database';
response_status_is ['GET' => '/database'], 200, 'response status is 200 for /database';

# response_content_like([$method, $path], $regexp, $test_name)
response_content_like( ['GET' => '/database'], qr{connected to test}, "connected to 'test' database" );
response_content_like( ['GET' => '/my.cnf'], qr{mysqld}, "my.cnf contains 'mysqld'" );

response_content_like( ['GET' => '/database_with_timeout'], qr{dbname1: test} );
response_content_like( ['GET' => '/database_with_timeout'], qr{dbname2: test} );


