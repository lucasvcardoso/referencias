#!/usr/local/cpanel/3rdparty/bin/perl
#Este script tem exemplos de como capturar dados ao ser chamado de dentro de um hook do cPanel/WHM,
#como gravar dados num arquivo de texto, desserializar um JSON, e gravar os dados numa base de dados
## Return errors if Perl experiences problems.
#use Switch;                # for character encoding
#use strict;                # to make sure your Perl code is well formed
use POSIX qw(strftime);
use strict;
use warnings;
use IO::Select;                    # Use objects to handle input.
use JSON::XS qw( decode_json );                    # Properly decode JSON.

# Get decoded input.
my $input = get_passed_data();

# Declare return variables and set their values.
#my ( $result_result, $result_message ) = do_something($input);

# Return the return variables and exit.
#print $input;

my $log = "\nE-mail criado com API 2";

#my $args = (%{$input}->{data}->{args});

#my $domain = $args{domain}->{'value'};

#my $email = $args{email}->{'value'};

#LogWrite($log . "Email: $email Domain: $domain");
#LogWrite($input);
my $aux ="";# "Email: " . $email . " Domain: " . $domain;

foreach my $key (keys (%{$input->{data}->{args}}))
{

        my %currentHash = (%{$input->{data}->{args}});
        my $value = $currentHash{$key};

        #my %currentHash = (%{$input}->{'data'}->{'args'});
        $aux .= $key . ":" . $value . "\n";

        #q
        #my %currentHash = (%{$input}->{data}->{args});
#
#       if($key eq "email"){
#               $aux .= " Email: " . ($currentHash{$key}->{'value'});
#       }
#       if($key eq "domain"){
#               $aux .= " Domain: " . ($currentHash{$key}->{'value'});
#       }
}

LogWrite("\n".$log ."\n" . $aux);

exit;

#Process data from STDIN.
sub get_passed_data {
        # Declare input variables.
        my $raw_data   = '';
        my $input_data = {};

        # Set up an input object.
        my $selects    = IO::Select->new();

        # Get input from STDIN.
        $selects->add( \*STDIN );

        # Process the raw output, and JSON-decode.
        if ( $selects->can_read(.1) ) {
                while (<STDIN>) {
                        $raw_data .= $_;
                }
                $input_data = decode_json($raw_data);
        }
# Return the output.
        return $input_data;
#       return $raw_data;
}

# Escreve os logs no arquivo de logs definido no arquivo de configuração
sub LogWrite
{
        my $logFileDate = strftime "%F", localtime;
        my $filePath = "/var/log/admin_revlin/$logFileDate-teste_hook.log";
        my $outS = ">>";
        if (!(-f $filePath))
        {
                my $outS = ">";
        }
        open my $fh, $outS, $filePath or die "Nao foi possivel escrever no arquivo de logs: $!";
        my $logTime = strftime "%F-%H:%M:%S", localtime;
        print $fh "$logTime $_[0]\n";
}
