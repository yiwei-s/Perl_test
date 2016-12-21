#!/usr/bin/perl
use strict;
use warnings;
use Scalar::Util qw(looks_like_number);
use List::Uniq ':all';
use List::MoreUtils;
use Data::Dumper;
 
my $file = $ARGV[0] or die "Need to get CSV file on the command line\n";
 
my $sum = 0;
my @fields = ();
my @line_list = ();
open(my $data, '<', $file) or die "Could not open '$file' $!\n";
my $line_ctr =0; 
while (my $line = <$data>) {
  chomp $line;
  
#  @fields = split "," , $line;
  @fields =  $line;
  #only print out first 5 lines like head
   if($line_ctr <= 5){
    print "$_\n" for @fields;
   }
  
  push @line_list, @fields;
  $line_ctr +=1;

}
# print "all the records in the list: \n";
# print "$_\n" for @line_list;
my $check_number =0;
my $check_col7 =0;
my @first_col = ();
my $word_spec_ctr = 0; #the word SpecStr counter
for my $array_ref (@line_list) {
    my $index =0;
    my @elements = split('\t', $array_ref);

    for my $ele (@elements){
      $index = $index +1;
      
      if ($ele eq "SpecStr"){
         $word_spec_ctr = $word_spec_ctr +1;
         }
         #get the first column list
      if($index == 1){
        push @first_col, $ele;
        }
      if($index == 5){
          print "$ele is", looks_like_number($ele) ? '' : ' not', " a number\n";
          if(looks_like_number($ele)){
           
            }
          else{
             $check_number =1;
            }
       }  
       
      }
      if( $index >7 or $index <7){
         $check_col7 =1;
       }
}
# result title

print "############################# RESULT #################################\n";
print "The file columns number check result: \n";
#check if the columns are 7
if($check_col7 ==1){
  print "The file does not have exact 7 tab delimited columns.\n";
  }
else{
  print "The file has exact 7 tab delimited columns.\n";
  }
#check if the fifth column are all numbers
if ($check_number ==0){
  print "The col 5 are all numbers.\n";
  }
else{
  print "The column 5 are not all numbers.\n";
  }
#check if the elements in first column are unique
my @sub_first_col = get_first_column(\@line_list);
check_unique_in_list(\@sub_first_col);
# my @uniq_first_col = uniq(@first_col);
# if ((scalar @uniq_first_col) == (scalar @first_col)){
  # print "The values in column 1 are unique.\n";
  # }
# else{
  # print "The values in column 1 are NOT unique\n";
  # }
#print out the word count of "SpecStr" ; 
print "The total occurrence of word <SpecStr> is $word_spec_ctr .\n" ;
#count_word({LINE_LIST=>\@line_list});
count_word(\@line_list);

#print "the function to count word is $word_count \n";
#############################
#sub to count the "SpecStr"
sub count_word {
  
  die "no parameter!\n" unless @_;
  my $word_spec_ctr = 0; #the word SpecStr counter
  # my %opt = %{ shift @_ };
  # my @input = $opt{LINE_LIST};
  # print Dumper \@input;
  my @input = @{$_[0]};
  for my $array_ref (@input) {
   
    my @elements = split('\t', $array_ref);

    for my $ele (@elements){
     
      #print "$ele";
      if ($ele eq "SpecStr"){
         $word_spec_ctr = $word_spec_ctr +1;
       }
      
       
    }
    #print "\n";
  }
  print "The word <SpecStr> counts: $word_spec_ctr \n";
}

#sub to get the first column
sub get_first_column  {
  my @first_col = ();
  my $word_spec_ctr = 0;  #the word SpecStr counter
  my @input = @{$_[0]};
  for my $array_ref (@input) {
    my $index =0;
    my @elements = split('\t', $array_ref);

    for my $ele (@elements){
      $index = $index +1;
      
      #get the first column list
      if($index == 1){
        push @first_col, $ele;
        }
           
      }
  }
  return @first_col;
}

#sub to check if the elements are unique
sub check_unique_in_list  {
  my @input = @{$_[0]};
  my @uniq_first_col = uniq(@input);
  if ((scalar @uniq_first_col) == (scalar @input)){
    print "The values in column 1 are unique.\n";
    }
  else{
    print "The values in column 1 are NOT unique\n";
    }
}
