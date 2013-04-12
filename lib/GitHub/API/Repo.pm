package GitHub::API::Repo;

# ABSTRACT: A repository

use common::sense;
use parent 'GitHub::API::Base';

use aliased 'GitHub::API::Repo::Hooks';
use aliased 'GitHub::API::Repo::Keys';

=method hooks

Returns a L<GitHub::API::Repo::Hooks> object, representing the hooks
associated with this repository.

=method keys

Returns a L<GitHub::API::Repo::Keys> object, representing the deploy
keys associated with this repository.

=cut

sub hooks { shift->_next_append(Hooks, '/hooks') }
sub keys  { shift->_next_append(Keys,  '/keys' ) }

sub info { $_[0]->{repo_info} //= $_[0]->_get_single }

sub is_fork   { !! $_[0]->info->{fork}     }
sub has_forks { $_[0]->info->{forks_count} }

sub forks {
    my $self = shift @_;

    return $self->{forks} if $self->{forks};

    local $self->{url} = "$self->{url}/forks";
    return $self->{forks} = $self->_get()
}

!!42;
__END__
