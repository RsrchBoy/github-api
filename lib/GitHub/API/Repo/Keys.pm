#
# This file is part of GitHub-API
#
# This software is Copyright (c) 2013 by Chris Weyl.
#
# This is free software, licensed under:
#
#   The GNU Lesser General Public License, Version 2.1, February 1999
#
package GitHub::API::Repo::Keys;
{
  $GitHub::API::Repo::Keys::VERSION = '0.000000_02';
}

# ABSTRACT: A list of a repository's hooks

use common::sense;
use autobox::Core;

use parent 'GitHub::API::Base';

#use aliased 'GitHub::API::Hook';

# debugging...
#use Smart::Comments '###';


sub all {
    my $self = shift @_;

    return $self->{_keys} //= $self->_get;
}


sub create {
    my ($self, %key) = @_;

    my $key = $self->_post(\%key);
    $self->{_keys}->push($key)
        if defined $self->{_keys};

    return $key;
}

!!42;

__END__

=pod

=encoding utf-8

=for :stopwords Chris Weyl

=head1 NAME

GitHub::API::Repo::Keys - A list of a repository's hooks

=head1 VERSION

This document describes version 0.000000_02 of GitHub::API::Repo::Keys - released March 30, 2013 as part of GitHub-API.

=head1 DESCRIPTION

See L<http://developer.github.com/v3/repos/keys/>.

=head1 METHODS

=head2 all()

Returns an array reference containing all the deploy keys associated with the
repository.

=head2 create(...)

Adds a public key to the repository as a deploy key.

See L<the GitHub API reference|http://developer.github.com/v3/repos/keys/#create>
for more information.

=head1 SEE ALSO

Please see those modules/websites for more information related to this module.

=over 4

=item *

L<GitHub::API|GitHub::API>

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
