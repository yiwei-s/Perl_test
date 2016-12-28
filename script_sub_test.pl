#!/usr/bin/perl


# Function definition
sub PrintList{
   my @list = @_;
   print "Given list is @list\n";
}
$a = 10;
@b = (1, 2, 3, 4);

# Function call with list parameter
PrintList($a, @b);

@array = qw/This is an array/;

print "This is the array: \n";
# for my $ele (@array){
   # print $ele;
   # }
print "@array";
print "\n";

