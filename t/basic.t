use strict;
use warnings;

use Test::More;
use Test::Requires::Env;

test_environments(qw{ GH_TOKEN GH_USER });

fail 'No tests!';

done_testing;
