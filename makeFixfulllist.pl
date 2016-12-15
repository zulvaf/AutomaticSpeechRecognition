use strict;
use File::Basename;

my $line;
my $w;
my $monophoneFile = "nonsilence_phones.txt";
my $triphoneFile = "fulllist0";
my $targetFile = "fulllist";
my $wintriFile = "mlf/wintri.mlf";

my @phones = ();

#open proto file
open (MonoFile,"$monophoneFile") || die ("Unable to open $monophoneFile file for reading");
#open target
open (TriFile,"$triphoneFile") || die ("Unable to open $triphoneFile file for reading");
#open target
open (TargetFile,">$targetFile") || die ("Unable to open $targetFile file for writing");
#open wintri
open (WintriFile,"$wintriFile") || die ("Unable to open $wintriFile file for writing");

while ($line = <TriFile>)  { 
	chomp ($line);
	push @phones, $line;
}

while ($line = <MonoFile>) {
	chomp ($line);
	push @phones, $line;
}

while ($line = <WintriFile>) {
	chomp ($line);
	my $firstLetter = substr($line, 0, 1);
	if ($firstLetter ne '#' && $firstLetter ne '.' && $firstLetter ne '"') {
		push @phones, $line;
	}
}

sub uniq {
    my %seen;
    grep !$seen{$_}++, @_;
}

my @filtered = uniq(@phones);
foreach $w (@filtered) {
    printf(TargetFile "%s\n", $w);
}


close (PhoneFile);
close (ProtoFile);
close (TargetFile);
close(WintriFile);
print "writing to $targetFile file done\n";