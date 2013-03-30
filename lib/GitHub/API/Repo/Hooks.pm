#
# This file is part of GitHub-API
#
# This software is Copyright (c) 2013 by Chris Weyl.
#
# This is free software, licensed under:
#
#   The GNU Lesser General Public License, Version 2.1, February 1999
#
package GitHub::API::Repo::Hooks;
{
  $GitHub::API::Repo::Hooks::VERSION = '0.000000_02';
}

# ABSTRACT: A list of a repository's hooks

use common::sense;
use autobox::JSON;

use parent 'GitHub::API::Base';

#use aliased 'GitHub::API::Hook';

# debugging...
#use Smart::Comments '###';


sub all {
    my $self = shift @_;

    return $self->{_hooks} //= $self->_get;
}

!!42;

__END__

=pod

=encoding utf-8

=for :stopwords Chris Weyl

=head1 NAME

GitHub::API::Repo::Hooks - A list of a repository's hooks

=head1 VERSION

This document describes version 0.000000_02 of GitHub::API::Repo::Hooks - released March 30, 2013 as part of GitHub-API.

=head1 METHODS

=head2 all

Returns all hooks associated with this repository as an array reference of
hash references.

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
