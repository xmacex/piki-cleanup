#!/usr/bin/perl
use strict;
use warnings;
use XML::LibXML;

my $schema_file = 'MARC21slim.xsd';
my $document    = $ARGV[0];

my $schema = XML::LibXML::Schema->new(location => $schema_file);

my $parser = XML::LibXML->new;
my $doc    = $parser->parse_file($document);

eval { $schema->validate($doc) };
die $@ if $@;

print "$document validated successfully\n";
