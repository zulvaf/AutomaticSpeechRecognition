#!/usr/local/bin/perl -w
use strict;
use File::Basename;

my ($file, $line, $fname, @labs, @words, $w);

my $mlfFilename = "mlf/wordlist.mlf";
my $dir = "transcript/*";
my @files = glob( $dir );

# open MLF file
open (MLF,">$mlfFilename") || die ("Unable to open mlf $mlfFilename file for writing");

print "writing to mlf file $mlfFilename\n";

print MLF ("\#\!MLF\!\#\n");

foreach $file (@files ){
  if ($file =~ /.tsv$/){
    open (LAB, "$file") || die ("Unable to open prompt file $file");
    while ($line = <LAB>) {
      chomp ($line);
      @labs = split(/\t/,$line);

      $fname = $labs[0];
      $fname =~ s/\.mfc//g;
      $fname =~ s/\.lab//g;

      $fname =~ s/^1_/A21LJL009A/; #A009
      $fname =~ s/^2_/B11LPM053B/; #B053
      $fname =~ s/^3_/A21LJM019C/; #A019
      $fname =~ s/^4_/B11LWM114D/; #B114
      $fname =~ s/^5_/B12LTM106E/; #B106
      $fname =~ s/^6_/B11LJM044F/; #B044
      $fname =~ s/^7_/B12LBM144G/; #B144
      $fname =~ s/^8_/C11LTL006H/; #C006
      $fname =~ s/^9_/B11LTM143I/; #B143
      $fname =~ s/^10_/A24LMM058J/; #A058

      print MLF ("\"$fname.lab\"\n");
      
      @words = split(/\s+/,$labs[1]);
      foreach $w (@words) {
        $w =~ s/\.//;
        printf(MLF "%s\n", $w);
      }
      print MLF (".\n");
    }   
  }
}

close (LAB);
close(MLF);
print "writing to $mlfFilename file done\n";
