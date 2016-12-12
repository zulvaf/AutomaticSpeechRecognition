use File::Basename;

my $filename = 'targetlist.txt';
open(my $fh, '>', $filename) or die "Could not open file '$filename' $!";

$dir = "./sounds/*";
my @files = glob( $dir );

foreach (@files ){
	$folderName = basename($_);
  foreach my $fp (glob("$_/*.wav")) {
  	$filename = fileparse($fp, qr/\.[^.]*/);
  	print $fh $fp;
	  print $fh " mfcc/";
	  print $fh $folderName;
	  print $fh "/";
	  print $fh $filename;
	  print $fh ".mfcc\n";
  }
}

close $fh or die "can't read close '$fp': $OS_ERROR";

system("HCopy -A -D -C configs/analysis.conf -S targetlist.txt");