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
#use Smart::Comments '###', '####';

=method new(user => $userid, token => $gh_token)

Returns a new instance; requires a valid GitHub user name and OAuth2 token.
We do not support unauthenticated access.

=cut

sub new {
    my ($class, %opts) = @_;

    $opts{user}        //= $ENV{GH_USER}  // `git config github.user`;
    $opts{token_owner} //= $opts{user};
    $opts{token}       //= $ENV{GH_TOKEN} // `git config github.token`;
    $opts{url}         //= q{};
    $opts{base_url}    //= 'https://api.github.com';
    $opts{ua}          //= HTTP::Tiny->new(
        verify_ssl => 1,
        agent      => __PACKAGE__ . ' @ ',
        %{ $opts{ua_opts} // {} },
    );

    $opts{headers}->{Authorization} ||= "token $opts{token}";
    $opts{_req} = sub {

        ### fetching: $opts{url}
        $opts{ua}->request(shift, $opts{url}, { headers => $opts{headers} }) };

    return $opts{api} = bless \%opts, $class;
}

=method user

Returns a L<GitHub::API::User> object representing the authenticated user.

=method org($org_name)

Returns a L<GitHub::API::Org> object representing the named organization.

=cut

sub user { shift->_next(User, '/user', ($_[0] ? (user => @_) : @_) ) }
sub org  { shift->_next(Org,  "/orgs/$_[0]", @_)                     }

!!42;
__END__

=for :stopwords OAuth2 Pithub itty-bitty

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
