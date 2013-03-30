package GitHub::API;

use common::sense;

# ABSTRACT: An itty-bitty interface to the GitHub API

use HTTP::Tiny;
use IO::Socket::SSL 1.56;
use Mozilla::CA;

use parent 'GitHub::API::Base';
use aliased 'GitHub::API::User';
use aliased 'GitHub::API::Org';

# debugging...
use Smart::Comments '###', '####';

sub new {
    my ($class, %opts) = @_;

    $opts{user}  //= $ENV{GH_USER}  // `git config github.user`;
    $opts{token} //= $ENV{GH_TOKEN} // `git config github.token`;
    $opts{url}   //= q{};
    $opts{base_url} ||= 'https://api.github.com';
    $opts{ua}    ||= HTTP::Tiny->new(
        verify_ssl => 1,
        agent      => __PACKAGE__ . ' @ ',
        %{ $opts{ua_opts} // {} },
    );

    $opts{headers}->{Authorization} ||= "token $opts{token}";
    $opts{_req} = sub {

        ### fetching: $opts{url}
        $opts{ua}->request(shift, $opts{url}, { headers => $opts{headers} }) };

    return bless \%opts, $class;
}

sub user  { shift->_next(User, '/user') }
sub users { ... } # needs a Users class

sub org { shift->_next(Org, "/orgs/$_[0]") }

!!42;
__END__

=head1 SYNOPSIS

    # tiny little chaining interface
    use GitHub::API;
    use autobox::JSON;

    say GitHub::API
        ->new
        ->user
        ->repo("moosex-attributeshortcuts")
        ->hooks
        ->all
        ->to_json
        ;

=head1 DESCRIPTION

B<WARNING: THIS IS INCOMPLETE AND WILL EAT YOUR REPOSITORIES!>

This is a very small interface to the GitHub v3 API, designed to do simple
things quickly, and with a minimum of fuss.

=head1 SEE ALSO

Net::GitHub

Pithub

=cut
