package GitHub::API::Repo;

# ABSTRACT: A repo

use common::sense;
use parent 'GitHub::API::Base';

use aliased 'GitHub::API::Repo::Hooks';
use aliased 'GitHub::API::Repo::Keys';

sub hooks { shift->_next_append(Hooks, '/hooks') }
sub keys  { shift->_next_append(Keys,  '/keys' ) }

!!42;
__END__
