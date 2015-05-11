package GitHub::API::Repo::Releases;

# ABSTRACT: A list of a repository's releases

use common::sense;
use autobox::Core;

use parent 'GitHub::API::Base';

#use aliased 'GitHub::API::Hook';

# debugging...
#use Smart::Comments '###';

=method all()

Returns an array reference containing all the releases associated with the
repository.

=cut

sub all {
    my $self = shift @_;

    return $self->{_releases} //= $self->_get;
}

=method create(...)

Creates a release.

See L<the GitHub API reference|http://developer.github.com/v3/repos/releases/#create-a-release>
for more information.

=cut

sub create {
    my ($self, %release) = @_;

    delete $self->{_releases};
    my $release = $self->_post(\%release);

    return $release;
}

=method rm($id)

Given a release id, deletes said release from the repository's list of releases.

See L<the GitHub API reference|http://developer.github.com/v3/repos/releases/#delete>
for more information.

=cut

sub rm {
    my ($self, $id) = @_;

    delete $self->{_releases};
    return $self->_delete(undef, "/$id");
}

!!42;
__END__

=head1 DESCRIPTION

See L<http://developer.github.com/v3/repos/releases/>.

=cut
