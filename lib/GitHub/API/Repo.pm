package GitHub::API::Repo;

# ABSTRACT: A repository

use common::sense;
use parent 'GitHub::API::Base';

use aliased 'GitHub::API::Repo::Hooks';
use aliased 'GitHub::API::Repo::Keys';
use aliased 'GitHub::API::Repo::Releases';

=method hooks

Returns a L<GitHub::API::Repo::Hooks> object, representing the hooks
associated with this repository.

=method keys

Returns a L<GitHub::API::Repo::Keys> object, representing the deploy
keys associated with this repository.

=cut

sub hooks    { shift->_next_append(Hooks,     '/hooks'    ) }
sub keys     { shift->_next_append(Keys,      '/keys'     ) }
sub releases { shift->_next_append(Releases,  '/releases' ) }

sub info { $_[0]->{repo_info} //= $_[0]->_get_single }

sub is_fork   { !! $_[0]->info->{fork}     }
sub has_forks { $_[0]->info->{forks_count} }

# full_name: userid/repo
# name: repo
# owner->login: userid

#sub raw_forks {
    #my $self = shift @_;

    #return $self->{raw_forks}
        #if $self->{raw_forks};

    #local $self->{url} = "$self->{url}/forks";
    #return $self->{raw_forks} = $self->_get();
#}

sub forks {
    my $self = shift @_;

    return $self->{forks}
        if $self->{forks};
    return $self->{forks} = []
        unless $self->has_forks;


    my $forks = do {
        local $self->{url} = "$self->{url}/forks";
        $self->_get;
    };

    ### and build each into their own repo instance...
    my $class = ref $self;
    my @my_forks = map {
        bless {
            %$self,
            all_forks => undef,
            raw_forks => undef,
            repo_info => $_,
            url       => "user/$_->{full_name}",
        }, $class
    } @$forks;

    $self->{raw_forks}    = $forks;
    return $self->{forks} = \@my_forks; #$self->_get();
}

sub all_child_forks {
    my $self = shift @_;

    return $self->{child_forks}
        if $self->{child_forks};

    my @forks;
    push @forks, @{ $_->all_child_forks }
        for $self->forks;

    return $self->{child_forks} = \@forks;
}

#sub all_forks {
    #my $self = shift @_;

    #return $self->{all_forks} if $self->{all_forks};

    #local $self->{url} = "$self->{url}/forks";
    #my $raw_forks6 = $self->_get();

    #return $self->{forks} = $self->_get();
#}

!!42;
__END__
