#
# This file is part of GitHub-API
#
# This software is Copyright (c) 2013 by Chris Weyl.
#
# This is free software, licensed under:
#
#   The GNU Lesser General Public License, Version 2.1, February 1999
#
package GitHub::API::Base;
{
  $GitHub::API::Base::VERSION = '0.000000_02';
}

use common::sense;
use autobox::JSON;

# ABSTRACT: Base class for GitHub::API classes

# debugging...
#use Smart::Comments '###';

sub _get {
    my $self = shift @_;

    ### fetching: $self->{base_url} . $self->{url}
    my $items = $self
        ->{ua}
        ->get(
            $self->{base_url} . $self->{url},
            { headers => $self->{headers} },
        )
        ->{content}
        ->from_json
        ;

    return ref $items eq 'ARRAY' ? $items : [ $items ];
}

sub _post {
    my ($self, $content, $path_part) = @_;

    my $url = $self->{base_url} . $self->{url};
    $url .= $path_part // q{};

    #### POST to: $url
    #### $content
    my $resp = $self
        ->{ua}
        ->post($url, { content => $content->to_json, headers => $self->{headers} })
        ;

    return $resp->{content}->from_json;
}

sub _next_append {
    my ($self, $class, $url_append) = @_;

    my %thing = %$self;
    $thing{url} .= $url_append;

    #### %thing
    return bless \%thing, $class;
}

sub _next {
    my ($self, $class, $url) = @_;

    my %thing = %$self;
    $thing{url} = $url;

    #### %thing
    return bless \%thing, $class;
}

!!42;

__END__

=pod

=encoding utf-8

=for :stopwords Chris Weyl

=head1 NAME

GitHub::API::Base - Base class for GitHub::API classes

=head1 VERSION

This document describes version 0.000000_02 of GitHub::API::Base - released March 30, 2013 as part of GitHub-API.

=head1 SEE ALSO

Please see those modules/websites for more information related to this module.

=over 4

=item *

L<GitHub::API|GitHub::API>

=back

=head1 SOURCE

The development version is on github at L<http://github.com/RsrchBoy/github-api>
and may be cloned from L<git://github.com/RsrchBoy/github-api.git>

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website
https://github.com/RsrchBoy/github-api/issues

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

Chris Weyl <cweyl@alumni.drew.edu>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2013 by Chris Weyl.

This is free software, licensed under:

  The GNU Lesser General Public License, Version 2.1, February 1999

=cut
