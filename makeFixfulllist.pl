use strict;
use File::Basename;

my $line;
my $w;
my $monophoneFile = "nonsilence_phones.txt";
my $triphoneFile = "fulllist0";
my $targetFile = "fulllist";

my @phones = ();

#open proto file
open (MonoFile,"$monophoneFile") || die ("Unable to open $monophoneFile file for reading");
#open target
open (TriFile,"$triphoneFile") || die ("Unable to open $triphoneFile file for reading");
#open target
open (TargetFile,">$targetFile") || die ("Unable to open $targetFile file for writing");

while ($line = <TriFile>)  { 
	chomp ($line);
	push @phones, $line;
}

while ($line = <MonoFile>) {
	chomp ($line);
	push @phones, $line;
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
print "writing to $targetFile file done\n";