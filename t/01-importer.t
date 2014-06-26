use strict;
use warnings;
use Catmandu::Importer::OAI;
use Test::More;

# skip live testing by default (mock server instead)
if ($ENV{RELEASE_TESTING}) {
    my $importer = Catmandu::Importer::OAI->new(
        url => 'http://biblio.ugent.be/oai',
        set => "allFtxt"
    );

    my $record = $importer->first;

    ok $record , 'listrecords';


    $importer = Catmandu::Importer::OAI->new(
        url => 'http://biblio.ugent.be/oai',
        set => "allFtxt",
        listIdentifiers => 1,
    );

    $record = $importer->first;

    ok $record, 'listidentifiers';
}

done_testing;
