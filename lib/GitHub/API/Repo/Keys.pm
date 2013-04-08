package GitHub::API::Repo::Keys;

# ABSTRACT: A list of a repository's hooks

use common::sense;
use autobox::Core;

use parent 'GitHub::API::Base';

#use aliased 'GitHub::API::Hook';

# debugging...
#use Smart::Comments '###';

=method all()

Returns an array reference containing all the deploy keys associated with the
repository.

=cut

sub all {
    my $self = shift @_;

    return $self->{_keys} //= $self->_get;
}

=method create(...)

Adds a public key to the repository as a deploy key.

See L<the GitHub API reference|http://developer.github.com/v3/repos/keys/#create>
for more information.

=cut

sub create {
    my ($self, %key) = @_;

    delete $self->{_keys};
    my $key = $self->_post(\%key);

    return $key;
}

=method rm($id)

Given a key id, deletes said key from the repository's list of deploy keys.

See L<the GitHub API reference|http://developer.github.com/v3/repos/keys/#delete>
for more information.

=cut

sub rm {
    my ($self, $id) = @_;

    delete $self->{_keys};
    return $self->_delete(undef, "/$id");
}

!!42;
__END__

=head1 DESCRIPTION

See L<http://developer.github.com/v3/repos/keys/>.

=cut
