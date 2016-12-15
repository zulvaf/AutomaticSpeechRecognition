# open file nonsilence_phones.txt
my @phones = ();
my $file = 'nonsilence_phones.txt';
open my $info, $file or die "Could not open $file: $!";
while( my $line = <$info>)  {
    chomp($line);
    push @phones, $line;
    print($line);
}
close $info;

my $w;
# foreach $w (@phones) {
#     print $w;
# }

# make tree.hed
open(my $fh, '>', 'tree.hed') or die "Could not open file tree.hed $!";
for ($i = 2; $i <= 4; $i = $i + 1) {
    foreach (@phones) {
        my $phone = $_;
        print $fh "TB 350 \"ST_$phone\_$i\_\" {(\"$phone\",\"*-$phone\+*\",\"$phone\+*\",\"*-$phone\").state[$i]}\n";
    }
}
print $fh "\n";
print $fh "TR 1\n";
print $fh "\n"; 
print $fh "AU \"./fulllist\" \n";
print $fh "CO \"./tiedlist\" \n";
print $fh "\n"; 
print $fh "ST \"./trees\" \n";
close ($fh);
