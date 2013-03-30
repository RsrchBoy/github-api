package GitHub::API::Repo::Keys;

# ABSTRACT: A list of a repository's hooks

use common::sense;
use autobox::JSON;
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

=cut

sub create {
    my ($self, %key) = @_;

    my $key = $self->_post(\%key);
    $self->{_keys}->push($key)
        if defined $self->{_keys};

    return $key;
}

!!42;
