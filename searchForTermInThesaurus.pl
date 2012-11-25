#!/usr/bin/perl
# Takes three arguments: an URL to a Solr, a subject heading, and a
# thesaurus. Returns stuff.
#
# This is a little convenience script, since i have reason to believe that
# this will be faster more agile than an XQuery with thousands of subject
# headings in it's 'where' clause, like so:
# 
#	for $subjectheading in /blahblahblah/datafield[@tag='650']
#	where $subjectheading/subfield[[@code='2' = 'ysa'] and [@code='a' = *thousands of illegal terms here*]]
#	return $subjectheading/..
#
# bad XQuery but you get the idea.
#
# Relies on SolrMarc MARC schema that comes with VuFind. That schema doesn't
# differentiate the different thesauri, but adds their identifier to the
# end of the topic -fields. Thus, f.ex. 'topic:"kahlaajalinnut ysa"' will
# find the terms which claim to come from the YSA thesaurus. A separate
# field per thesaurus would be nicer perhaps, instead of concatenating
# strings. Anyways...

use WebService::Solr;

if ($#ARGV + 1 != 3) {
	die("I want three arguments; a Solr URL and a term, and a thesaurus");
}

# eat command line arguments
my $solrUrl = $ARGV[0];		# f.ex. http://localhost:8080/solr
my $term = $ARGV[1];		# f.ex. 'topic:kirjallisuudentutkimus';
my $thesaurus = $ARGV[2];	# f.ex. 'ysa'

# construct some conveniences
my $termInContext = $term . ' ' . $thesaurus;
my $query = 'topic' . ':' . '"' . $termInContext . '"';

# for debugging
print($query, "\n");

# talk to Solr
# needs some error handling
my $solr = WebService::Solr->new($solrUrl);

# output a report
my $searchResult = $solr->search($query, {'rows' => 2**16});
for my $doc ($searchResult->docs) {
	print("* ", $doc->value_for("title"));
	for my $value ($doc->values_for("id")) {
		print(" ", $value);
	}
	print("\n");
}
