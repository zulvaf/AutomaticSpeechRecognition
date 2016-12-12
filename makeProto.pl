use File::Basename;

my $filename = 'train.scp';
open(my $fh, '>', $filename) or die "Could not open file '$filename' $!";

$dir = "mfcc/*";
my @files = glob( $dir );

foreach (@files ){
	$folderName = basename($_);
	foreach my $fp (glob("$_/*.mfcc")) {
	  	$filename = fileparse($fp, qr/\.[^.]*/);
	  	print $fh $fp;
		print $fh "\n";
	}
}

close $fh or die "can't read close '$fp': $OS_ERROR";

system("HCompV -A -D -T 1 -C configs/proto.conf -f 0.01 -m -S train.scp -M hmms/hmm0 proto");