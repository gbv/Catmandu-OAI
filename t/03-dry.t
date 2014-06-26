use strict;
use warnings;
use Catmandu::Importer::OAI;
use Test::More;

# helper methods to write tests
my $importer;
sub oai { Catmandu::Importer::OAI->new( dry => 1, @_ ) }
sub url { my @s = split /[?&]/, $_[0]; shift(@s).'?'.join('&',sort @s) }

# actual tests
$importer = oai( url => 'http://example.org/oai', set => "all" );
is url($importer->first->{url}), 'http://example.org/oai?metadataPrefix=oai_dc&set=all&verb=ListRecords';

$importer = oai( url => 'http://example.org/oai', ids => 'foo,bar' );
my $items = $importer->to_array;
is scalar @$items, 2;
is url($items->[0]->{url}), 'http://example.org/oai?identifier=foo&metadataPrefix=oai_dc&verb=GetRecord';
is url($items->[1]->{url}), 'http://example.org/oai?identifier=bar&metadataPrefix=oai_dc&verb=GetRecord';

done_testing;
