package GHA;

# ABSTRACT: Shortcut package for one-liners

use common::sense;
use parent 'GitHub::API';

!!42;
__END__

=head1 SYNOPSIS

    # from the command line...
    perl -MGHA -E 'say GHA->new->user->repo("autobox-JSON")->info'

=head1 DESCRIPTION

This package is nothing but a shim to make one-liners using L<GitHub::API>
easier to write.  If you're using this in a script/package, you should just
reference C<GitHub::API> directly.

If you really want to use this shortcut anyways, there's nothing I can (or
will) do to stop you :)  An alternate approach, however, that I would
recommend over using this package directly would be with L<aliased>:

    use aliased 'GitHub::API' => 'GHA';

=cut
