package GitHub::API::Base;

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
