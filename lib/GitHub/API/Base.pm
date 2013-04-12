package GitHub::API::Base;

use common::sense;
use autobox::JSON 0.0004;

# ABSTRACT: Base class for GitHub::API classes

# debugging...
#use Smart::Comments '###';

sub _get_single {
    my $self = shift @_;

    ### fetching: $self->{base_url} . $self->{url}
    my $res = $self->{latest_response} = $self
        ->{ua}
        ->get(
            $self->{base_url} . $self->{url},
            { headers => $self->{headers} },
        )
        ;

    die "Oh, the shame! $res->{status}: $res->{reason}"
        unless $res->{success};

    my $item = $res->{content}->decode_json;

    ### $item
    return $item;
}

sub _get { my $x = shift->_get_single(@_); ref $x eq 'ARRAY' ? $x : [ $x ] }

sub _post {
    my ($self, $content, $path_part) = @_;

    my $url = $self->{base_url} . $self->{url};
    $url .= $path_part // q{};

    ### POST to: $url
    #### $content
    my $resp = $self
        ->{ua}
        ->post($url, { content => $content->to_json, headers => $self->{headers} })
        ;

    return $resp->{content}->from_json;
}

sub _delete {
    my ($self, $content, $path_part) = @_;

    my $url = $self->{base_url} . $self->{url};
    $url .= $path_part // q{};

    ### DELETE to: $url
    my $resp = $self
        ->{ua}
        ->delete($url, { headers => $self->{headers} })
        ;

    return $resp;
}

sub _next_append {
    my ($self, $class, $url_append) = @_;

    my %thing = %$self;
    $thing{url} .= $url_append;

    #### %thing
    return bless \%thing, $class;
}

sub _next {
    my ($self, $class, $url, %thing) = @_;

    %thing = (%$self, %thing);
    $thing{url} = $url;

    #### %thing
    return bless \%thing, $class;
}

!!42;
__END__

=head DESCRIPTION

This is a base class providing common functionality to the C<GitHub::API::*>
classes...  There are no user-servicable parts in here.

=cut
