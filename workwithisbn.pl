#!/usr/bin/perl
# Testing out the Business:ISBN Perl module, and also the Log::Log4Perl logger utility

use Business::ISBN qw(%ERROR_TEXT);
use MARC::Batch;
use Log::Log4perl qw(:easy);

Log::Log4perl->easy_init($ERROR);

my $logger = get_logger();
# my $batch = MARC::Batch->new('USMARC', '/home/mace/turku/tietokantoja/vaski-kunnostettu.mrc');
my $batch = MARC::Batch->new('USMARC', 'testi.mrc');
$batch->strict_off();

while ($record = $batch->next()) {
	$field020 = $record->subfield("021", "a");
#	print($field020, "\n");
	$iamaisbn = Business::ISBN->new($field020);

	if (! $iamaisbn) {
		$logger->error("burp what are u talking about, this doesn't taste like an ISBN code. Record ID ", $record->field('001')->data());
		next;
	}
#	print($iamaisbn->as_isbn13->as_string, "\n");
	$logger->info("om nom nom. Record ID ", $record->field('001')->data());
#	print($iamaisbn->as_isbn13->as_string, "; ", $ERROR_TEXT{$iamaisbn->error}, "\n");
#	print($iamaisbn->isbn, "\n");
}
