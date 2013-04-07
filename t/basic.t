use strict;
use warnings;
use autodie;

use Test::More;
use Test::Requires::Env;
use Test::Fatal;

use GitHub::API;

test_environments(qw{ GH_TOKEN GH_USER });

my $key_title = 'testing GitHub::API';
my $repo_name = 'issues';
my $repo_url  = "git\@github.com:$ENV{GH_USER}/$repo_name.git";

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

my ($key_id, $key_struct);

subtest 'add a deploy key to a repo' => sub {

    my $pub_key = do { open my $fh, '<', 't/test.pub'; local $/; <$fh> };
    my $key = $keys->create(title => $key_title, key => $pub_key );

    note explain $key;
    ok defined $key->{id}, 'an id was returned';
    $key->{verified} = !!$key->{verified}
        if exists $key->{verified};
    #ok exists $key->{verified}, 'verified was returned...';
    #ok delete $key->{verified}, '...and is true';

    $key_id = $key->{id};
    chomp $pub_key;

    $key_struct = {
        id       => $key_id,
        key      => $pub_key,
        title    => $key_title,
        url      => "https://api.github.com/user/keys/$key_id",
        verified => 1,
    };

    is_deeply
        $key, $key_struct,
        'key struct as expected',
        ;

    return;
};


# TODO key already exists tests
#
# {
#   'errors' => [
#     {
#       'code' => 'custom',
#       'field' => 'key',
#       'message' => 'key is already in use',
#       'resource' => 'PublicKey'
#     }
#   ],
#   'message' => 'Validation Failed'
# }



#subtest 'add an existing key' => sub { };
#subtest 'edit a key' => sub { };
#subtest 'get a key by id' => sub { };
#subtest 'get a list of keys' => sub { };

subtest 'delete key' => sub {

    is exception { $keys->rm($key_id) }, undef, 'deleting key lives!';
    return;
};

done_testing;
