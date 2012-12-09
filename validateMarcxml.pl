#!/usr/bin/perl
use strict;
use warnings;
use XML::LibXML;

my $schema_file = 'MARC21slim.xsd';
my $document    = $ARGV[0];

my $schema = XML::LibXML::Schema->new(location => $schema_file);

my $parser = XML::LibXML->new (recover => 1);
my $collectionDom = $parser->parse_file($document);

my $xc = XML::LibXML::XPathContext->new($collectionDom);
$xc->registerNs("marc", "http://www.loc.gov/MARC21/slim");
my $records = $xc->findnodes('/marc:collection/marc:record');

eval {
	$schema->validate($collectionDom);
	print $@;
};


#print($records->size . "\n");
#my $oneRecord = $records->get_node(10);
# print $oneRecord;
#eval {
#	$schema->validate($oneRecord);
#};
#print $@;

foreach my $record ($records->get_nodelist) {
	print("++ validating record \n");
	eval {
		$schema->validate($record);
	print $@;
	};
}
