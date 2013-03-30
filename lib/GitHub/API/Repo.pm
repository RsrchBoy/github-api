package GitHub::API::Repo;

# ABSTRACT: A repo

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

!!42;
__END__
