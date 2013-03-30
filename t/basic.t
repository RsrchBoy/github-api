use strict;
use warnings;
use autodie;

use Test::More;
use Test::Requires::Env;

use GitHub::API;

test_environments(qw{ GH_TOKEN GH_USER });

# will get from the environment
my $gh = GitHub::API->new();
isa_ok $gh, 'GitHub::API';
my $user = $gh->user;
isa_ok $user, 'GitHub::API::User';
my $repo = $user->repo('issues');
isa_ok $repo, 'GitHub::API::Repo';
my $hooks = $repo->hooks;
isa_ok $hooks, 'GitHub::API::Repo::Hooks';
my $keys = $repo->keys;
isa_ok $keys, 'GitHub::API::Repo::Keys';

note 'testing repo-based deploy key creation and deletion';
# ssh-keygen -f x/test -C 'testing' -N ''

is_deeply $keys->all, [], 'all returns an arrayref and is empty!';

my $pub_key = do { open my $fh, '<', 't/test.pub'; local $/; <$fh> };
my $key = $keys->create(title => 'testing!', key => $pub_key );

note explain $key;
ok defined $key->{id}, 'an id was returned';
ok exists $key->{verified}, 'verified was returned...';
ok delete $key->{verified}, '...and is true';

my $id = $key->{id};
chomp $pub_key;

is_deeply
    $key,
    {
        id    => $id,
        key   => $pub_key,
        title => 'testing!',
        url   => "https://api.github.com/user/keys/$id",
    },
    'key struct as expected',
    ;


done_testing;
