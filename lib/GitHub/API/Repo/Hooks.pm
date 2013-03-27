package GitHub::API::Repo::Hooks;

# ABSTRACT: A list of a repository's hooks

use common::sense;
use autobox::JSON;

use parent 'GitHub::API::Base';

#use aliased 'GitHub::API::Hook';

# debugging...
use Smart::Comments '###';

sub all {
    my $self = shift @_;

    return $self->{_hooks} //= $self->_get;
}

!!42;
