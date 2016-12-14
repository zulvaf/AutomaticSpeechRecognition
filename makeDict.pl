use strict;
use File::Basename;
use List::MoreUtils qw{ any firstidx };

# list of lexicon
my @lexicons = ();

# open file data/lexicon.txt
my $file = 'data/lexicon.txt';
open my $info, $file or die "Could not open $file: $!";
while( my $line = <$info>)  { 
	push @lexicons, $line;
}
close $info;

# make lexicon
my $filename = 'lexicon';
open(my $fh, '>', 'lexicon') or die "Could not open file '$filename' $!";
foreach (@lexicons) {
	my @words = split / /, $_;
	print $fh $words[0];
	print $fh " [";
	print $fh $words[0];
	print $fh "]";
	shift(@words);
	foreach (@words) {
		print $fh " ";
		print $fh $_;
	}
}
close ($fh);

# make wlist
my ($file, $line, $fname, @labs, @words, $w, @wlist);
my $dir = "transcript/*";
my @files = glob( $dir );

open (MLF,">wlist") || die ("Unable to open wlist file for writing");

foreach $file (@files ){
  	if ($file =~ /.tsv$/){
    	open (LAB, "$file") || die ("Unable to open prompt file $file");
    	while ($line = <LAB>) {
      		chomp ($line);
      		@labs = split(/\t/,$line);
      		@words = split(/\s+/,$labs[1]);
      		foreach $w (@words) {
        		$w =~ s/[?.!,;]?$//;
        		$w =~ s/[?.!,;]?$//;
        		$w = lc $w;
        		push @wlist, $w;
      		}
    	}   
  	}
}

sub uniq {
    my %seen;
    grep !$seen{$_}++, @_;
}

my @filtered = uniq(@wlist);
foreach $w (@filtered) {
    printf(MLF "%s\n", $w);
}
close(LAB);
close(MLF);

# system("HDMan -m -w wlist -n data/nonsilence_phones.txt -l dlog dict lexicon");