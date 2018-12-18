use strict;
use Term::ANSIColor;

# Alias bool
my ($TRUE, $FALSE) = (1, 0);

# The second argument is bool
sub color_print {
  my ($color, $is_bold, $msg) = @_;

  my $bold = $is_bold ? "bold" : "";

  print color "$bold $color";
  print "$msg \n";
  print color 'reset';
}

# Print red info when error msg is comming
sub executed_info {
  my ($output_msg) = @_;

  if($output_msg =~ /[Ee]rror/){
    color_print("red", $TRUE, $output_msg);
  } else {
    print "$output_msg";
  }
}

sub traverse_info {
  my ($infos) = @_;

  foreach my $info ($infos){
    executed_info($info)
  }
}

sub executed_shell {
  my ($command) = @_;

  # output in stdout
  return `$command 2>&1`;
}

my ($executedFile) = @ARGV;

my @line = executed_shell("mcs $executedFile");
$result = traverse_info(@line);


# xxx.cs to xxx.exe
$executedFile =~ s/([^.]+)(?:\.[a-zA-Z]+)?/$1.exe/;

@line = executed_shell("mono $executedFile");
traverse_info(@line);

