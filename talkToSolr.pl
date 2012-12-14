#!/usr/bin/perl
# Takes two arguments: an URL to a Solr, and a query to return. Returns stuff.

use WebService::Solr;

if ($#ARGV + 1 != 2) {
	die("I want two arguments; a Solr URL and a Solr query");
}

my $solrUrl = $ARGV[0];		# f.ex. http://localhost:8080/solr
my $query = $ARGV[1];		# f.ex. 'topic:kirjallisuudentutkimus';

my $solr = WebService::Solr->new($solrUrl);

my $searchResult = $solr->search($query, {'rows' => 2**16});
for my $doc ($searchResult->docs) {
	print("* ", $doc->value_for("title"));
	for my $value ($doc->values_for("ctrlnum")) {
		print(" ", $value);
	}
	print("\n");
}
