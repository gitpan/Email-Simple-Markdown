use strict;
use warnings;

use Test::More;

use Email::Simple::Markdown;

plan skip_all => "No markdown module found"
    unless eval { Email::Simple::Markdown->find_markdown_engine };

plan tests => 2;

my $txt = '[this](http://metacpan.org/search?q=Email::Simple::Markdown) is *amazing*';

SKIP:
for my $engine ( qw/ Text::MultiMarkdown Text::Markdown / ) {
    skip "$engine required", 1 unless eval "use $engine; 1";

    my $email = Email::Simple::Markdown->create(
        header => [
            From    => 'me@here.com',
            To      => 'you@there.com',
            Subject => q{Here's a multipart email},
        ],
        body => $txt,
        markdown_engine => $engine,
    );

    ok $email->as_string, $engine;
}



