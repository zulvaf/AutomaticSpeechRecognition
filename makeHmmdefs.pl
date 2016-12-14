#!/usr/local/bin/perl -w
use strict;
use File::Basename;

my $line;
my $phoneFilename = "nonsilence_phones.txt";
my $protoFilename = "hmms/hmm0/proto";
my $targetFilename = "hmms/hmm0/hmmdefs";

# open phone files
open (PhoneFile,"$phoneFilename") || die ("Unable to open $phoneFilename file for reading");
#open proto file
open (ProtoFile,"$protoFilename") || die ("Unable to open $protoFilename file for reading");
#open target
open (TargetFile,">$targetFilename") || die ("Unable to open $targetFilename file for writing");

my @hmmlines = <ProtoFile>;
my $hmmsize = @hmmlines;
@hmmlines = @hmmlines[4..$hmmsize-1];
$hmmsize = @hmmlines;

while($line = <PhoneFile>){
  chomp ($line);
  print TargetFile ("~h " . "\"$line\"" . "\n");
  for(my $i = 0; $i< $hmmsize; $i++){
    print TargetFile ($hmmlines[$i]);
  }
}

close (PhoneFile);
close (ProtoFile);
close (TargetFile);
print "writing to $targetFilename file done\n";
