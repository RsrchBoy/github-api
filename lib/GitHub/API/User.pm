package GitHub::API::User;

use common::sense;

# ABSTRACT: A user

use aliased 'GitHub::API::Repo';

# debugging...
#use Smart::Comments '###', '####';

=method repo($repo_name)

Returns a L<GitHub::API::Repo> object for the named repository.

=cut

sub repo {
    my ($self, $repo) = @_;

    my %repo = (%$self, repo => $repo);
    $repo{url} = "/repos/$self->{user}/$repo";

    #### %repo
    return bless \%repo, Repo;
}



!!42;
