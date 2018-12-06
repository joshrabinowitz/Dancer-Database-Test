use Test::More tests => 7;
use strict;
use warnings;
use File::Slurp::Tiny qw(read_file);
use Try::Tiny;

# the order is important
use DancerDBTest;
use Dancer::Test;

route_exists [GET => '/database'], 'a route handler is defined for /database';
response_status_is ['GET' => '/database'], 200, 'response status is 200 for /database';

# response_content_like([$method, $path], $regexp, $test_name)
response_content_like( ['GET' => '/database'], qr{connected to test}, "connected to 'test' database" );
response_content_like( ['GET' => '/my.cnf'], qr{mysqld}, "my.cnf contains 'mysqld'" );

response_content_like( ['GET' => '/database_with_timeout'], qr{name1: test} );
response_content_like( ['GET' => '/database_with_timeout'], qr{name2: test} );

my $content = '';
try { $content = read_file( "/etc/my.cnf" ); } catch {};
try { $content = read_file( "/etc/mysql/my.cnf" ); } catch {};
ok( $content, "read my.cnf" );

#diag( "content: $content" );

