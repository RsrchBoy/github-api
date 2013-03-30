#
# This file is part of GitHub-API
#
# This software is Copyright (c) 2013 by Chris Weyl.
#
# This is free software, licensed under:
#
#   The GNU Lesser General Public License, Version 2.1, February 1999
#
package GitHub::API;
{
  $GitHub::API::VERSION = '0.000000_02';
}

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
#sub users { ... } # needs a Users class

sub org { shift->_next(Org, "/orgs/$_[0]") }

!!42;

__END__

=pod

=encoding utf-8

=for :stopwords Chris Weyl OAuth2 Pithub itty-bitty

=head1 NAME

GitHub::API - An itty-bitty interface to the GitHub API

=head1 VERSION

This document describes version 0.000000_02 of GitHub::API - released March 30, 2013 as part of GitHub-API.

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

=head1 METHODS

=head2 new(user => $userid, token => $gh_token)

Returns a new instance; requires a valid GitHub user name and OAuth2 token.
We do not support unauthenticated access.

=head2 user

Returns a L<GitHub::API::User> object representing the authenticated user.

=head2 org($org_name)

Returns a L<GitHub::API::Org> object representing the named organization.

=head1 SEE ALSO

Please see those modules/websites for more information related to this module.

=over 4

=item *

L<Net::GitHub|Net::GitHub>

=item *

L<Pithub|Pithub>

=back

=head1 SOURCE

The development version is on github at L<http://github.com/RsrchBoy/github-api>
and may be cloned from L<git://github.com/RsrchBoy/github-api.git>

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website
https://github.com/RsrchBoy/github-api/issues

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

Chris Weyl <cweyl@alumni.drew.edu>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2013 by Chris Weyl.

This is free software, licensed under:

  The GNU Lesser General Public License, Version 2.1, February 1999

=cut
