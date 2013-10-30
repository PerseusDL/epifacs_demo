#!/usr/bin/perl
# Converts a CSV download of the Epifacs Image Collection 
# Backed by (Google Fusion Table https://www.google.com/fusiontables/DataSource?docid=1tnOoN42lTeJraC6q7orSG1b7UlbyEmT6moBQ954) 
# to triples for loading in a CITE SPARQL Image Service

use strict;
use Text::CSV;

my $file = $ARGV[0];

unless ($file && -f $file ) { 
   print "Usage: $0 <input file>\n";
   exit 1;
}

my $csv = Text::CSV->new({ binary => 1, eol => $/});

my %image_versions;
my %images;
open my $io, "<", $file or die "$file: $!\n";
while (my $row = $csv->getline ($io)) {
    my @fields = @$row;
    my $urn = $fields[0];
    my $work = $fields[9]; 
    next unless $urn =~ /urn:cite/;
    my $rights = $fields[2];
    my $caption = join " ", ($fields[4], $fields[3]);
    # urn:cite:ns:coll.n.v
    my @urn_parts = split /\./, $urn;
    my $urn_no_ver = join ".", @urn_parts[0..1];
    my $collection = $urn_parts[0];
    my $ver = 0;
    if (scalar @urn_parts > 2) {
        $ver =  $urn_parts[2];
    }
    if (! exists $image_versions{$urn_no_ver}) {
        $image_versions{$urn_no_ver} = 0;
    } 
    if ($ver >= $image_versions{$urn_no_ver}) {
        my $img =join ",", (qq!"$urn_no_ver"!,qq!"$caption"!,qq!"$rights"!);
        $image_versions{$urn_no_ver} = $ver;
        $images{$urn_no_ver} = { 
            'caption' => $caption, 
            'collection' => $collection,
            'rights' => $rights,
            'work' => $work };
    }
}

print <<"EOS";
\@prefix hmt:        <http://www.homermultitext.org/hmt/rdf/> .
\@prefix cite:        <http://www.homermultitext.org/cite/rdf/> .
\@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
\@prefix crm: <http://www.cidoc-crm.org/cidoc-crm/>.
<urn:cite:perseus:epifacsimg> rdf:type cite:ImageArchive .
<urn:cite:perseus:epifacsimg> rdf:label "Perseus Digital Library images of Greek Funerary Inscriptions. Creator Marie-Claire Beaulieu, PhD." .
<urn:cite:perseus:epifacsimg> hmt:path "/usr/local/perseus/collections/images/epifacs" .
EOS

foreach my $key (sort keys %images) {
    
    print qq!<$key> cite:belongsTo <$images{$key}{'collection'}> .\n!;
    print qq!<$images{$key}{'collection'}> cite:possesses <$key> .\n!;
    print qq!<$key> rdf:label "$images{$key}{'caption'}" .\n!;
    print qq!<$key> cite:license "$images{$key}{'rights'}" .\n!;
    if ($images{$key}{'work'} && $images{$key}{'work'} =~ /^urn:cts:/) {
        print qq!<$images{$key}{'work'}> crm:P138i_has_representation <$key> .\n!;
    }
}
