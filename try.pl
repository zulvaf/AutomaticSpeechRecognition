#!/usr/bin/perl
####################################################################
###
### script name : ProcessJuliusOutput.pl
### version: 0.1
### created by: Ken MacLean
### mail: contact@voxforge.org
### Date: 2006.09.12
### Command: perl ./ProcessJuliusOutput.pl
###    
### Copyright (C) 2006 Ken MacLean
###
### This program is free software; you can redistribute it and/or
### modify it under the terms of the GNU General Public License
### as published by the Free Software Foundation; either version 2
### of the License, or (at your option) any later version.
###
### This program is distributed in the hope that it will be useful,
### but WITHOUT ANY WARRANTY; without even the implied warranty of
### MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
### GNU General Public License for more details.
###                                                             
####################################################################

use strict;
my ($line, $label, $filein, $fileout, %seen);
my (@line_array, $line_array);
my $filename = 'wavlst';
if (@ARGV != 2) {
  print "usage: $0 filein fileout\n\n"; 
  exit (0);
}
# read in command line arguments
($filein, $fileout) = @ARGV;

open (FILEIN,"$filein") || die ("Unable to open $filein for reading");
open (FILEOUT,">$fileout") || die ("Unable to open $fileout for writing");
open (WAVIN,"$filename") || die ("Unable to open $filename for reading");
my @wavlines = <WAVIN>;
my $wavsize = @wavlines;
my @wavnames = ();

my $iWav;
for (my $i = 0; $i < $wavsize; $i++){
  chomp($wavlines[$i]);
  my @temp = split /\//, $wavlines[$i];
  $wavnames[$iWav] = $temp[2];
  $wavnames[$iWav] =~ s/\.wav/\.rec/;
  $iWav++;
}   

$iWav = 0;
print (FILEOUT "#!MLF!#\n");
while ($line = <FILEIN>) {
  chomp ($line);
  if ($line =~ /input speechfile: /) {
    $line =~ s/input speechfile: //;
    $line =~ s/\.wav/\.rec/;
    $line =~ s/wav\///;
    print (FILEOUT "\"*\/$line\"\n");
  } elsif ($line =~ /input MFCC file: /) {
    $line =~ s/input MFCC file: //;
    $line =~ s/\.mfcc/\.rec/;
    $line =~ s/mfcc\///;
    $line =~ s/^[^\/]*\///;
    print (FILEOUT "\"*\/$line\"\n");
  } elsif ($line =~ /sentence1: /) {  
    # print (FILEOUT "\"*\/$wavnames[$iWav]\"\n");
    $line =~ s/sentence1: //;
    $line =~ s/<s> //;
    $line =~ s/ <\/s>//;
    @line_array=split(/\s+/, $line);
    foreach $line_array (@line_array) {
      print (FILEOUT "$line_array\n");
    }
    $iWav++;
    print (FILEOUT "\.\n");
  }
}  
close(FILEIN);
close(FILEOUT);
close(WAVIN);


open( FILE, "<$fileout" ); 
my @LINES = <FILE>; 
close( FILE ); 
open( FILE, ">$fileout" );
for my $i (0 .. $#LINES) {
  my $temp = $LINES[ $i ];
  if (substr($LINES[ $i ],0,1) eq '"') {
    print FILE $LINES[ $i ] unless ( substr($LINES[ $i + 1 ],0,1) eq '"' ); 
  }
  else {
    print FILE $LINES[$i];
  }
}
close( FILE ); 