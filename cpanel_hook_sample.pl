#!/usr/local/cpanel/3rdparty/bin/perl  
## Return errors if Perl experiences problems.
use POSIX qw( strftime );
use strict;
use warnings;
use IO::Select; 		#Use objects to handle input.
use JSON::XS qw( decode_json );	#Properly decode JSON.
use DBI; 			#Standard database interface for Perl
use DBD::mysql;			#Perl module to connect to MySQL
use Sys::Hostname;

my $operation = shift;

# Get decoded input.
my $input = get_passed_data();

my $database = "gateway_email";

my $aux = "";

foreach my $key (keys (%{$input->{data}->{args}}))
{
        my %currentHash = (%{$input->{data}->{args}});
        my $value = $currentHash{$key};

	$aux .= $key . ":" . $value . "\n";
}

my %currentHash = (%{$input->{data}->{args}});

my $email = $currentHash{'email'};

my $domain = $currentHash{'domain'};

my $querySelect = "SELECT idt_domain FROM central_domain WHERE des_domain = ?";

my @data = SelectFromMySql($database, $querySelect, $domain);

my $idt_domain = $data[0];

if ($idt_domain eq "")
{
	my $queryInsertDomain = "INSERT INTO central_domain (des_domain, idt_status) VALUES (?, 0)";
	my @valueDomain = ($domain);
	my $login = getlogin || getpwuid($<);
	$idt_domain = InsertIntoMySql($database, $queryInsertDomain, @valueDomain);
	LogWrite("- Dominio inserido na base: " . $domain . " - usuario realizando operacao: " . $login);
}
my $serverIp =  GetInternalIp();

$querySelect = "SELECT idt_server FROM central_server WHERE des_server = ?";

@data = SelectFromMySql($database, $querySelect,  $serverIp);

my $idt_server = $data[0];

if ($idt_server eq "")
{
        my $queryInsertServer = "INSERT INTO central_server (des_server) VALUES (?)";
	my @valueServer = ($serverIp);
	my $login = getlogin || getpwuid($<);
        $idt_server = InsertIntoMySql($database, $queryInsertServer, @valueServer);
	LogWrite("- Servidor inserido na base: " . $serverIp . " - usuario realizando operacao: " . $login);
}

if( $operation eq "addpop")
{
	my $queryInsert = "INSERT INTO gateway_email.central_email (des_email, idt_domain, idt_server, idt_status) VALUES (?, ?, ?, 0)";

	my @values = ($email, $idt_domain, $idt_server);
	my $login = getlogin || getpwuid($<);
	InsertIntoMySql($database, $queryInsert, @values);
	
	LogWrite("- Email inserido na base: " . $email . "@" . $domain . " - usuario realizando operacao: " . $login);
}

if( $operation eq "delpop" )
{
	my $queryDelete = "DELETE FROM central_email WHERE des_email = ? AND idt_domain = ? AND idt_server = ?";
	my @values = ($email, $idt_domain, $idt_server);
	my $login = getlogin || getpwuid($<);
	DeleteFromMySql($database, $queryDelete, @values);	
	
	LogWrite("- Email deletado da base: " . $email . "@" . $domain . " - usuario realizando operacao: " . $login);
}

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
}

# Writes to the log file 
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
        print $fh "\n$logTime $_[0]";
}

# Connect to the databased informed
sub ConnectToMySql
{
	my ($database) = @_;

        #Open the accessDB file to retrieve the database name, host name, user name, and password
        open(ACCESS_INFO, "<\/usr\/local\/cpanel\/hooks\/email\/accessDB") || die "Can't access login credentials";

        #Assign the values in the accessDB file to the variables
        my $databaseName = <ACCESS_INFO>;
        my $host = <ACCESS_INFO>;
        my $userid = <ACCESS_INFO>;
        my $passwd = <ACCESS_INFO>;

        #Assign the values to the connection variable
        my $connectionInfo = "dbi:mysql:$database:$host";

        close(ACCESS_INFO);

        chomp($databaseName, $host, $userid, $passwd);

        my $connectionObj = DBI->connect($connectionInfo,$userid,$passwd);

	#The value of this connection is returned by the sub-routine
        return $connectionObj;
}

sub SelectFromMySql
{
	my ($database, $querySelect, @value) = (@_);
	
	my $connection = ConnectToMySql($database);

	my $statement = $connection->prepare($querySelect);

	$statement->execute(@value);

	my @data = $statement->fetchrow_array();
	
	return @data;
}

sub InsertIntoMySql
{
	my ($database, $queryInsert, @values) = @_;
        
	my $connection = ConnectToMySql($database);

        my $statement = $connection->prepare($queryInsert);

        $statement->execute(@values);

	return $statement->{mysql_insertid}
}

sub DeleteFromMySql
{
	my ($database, $queryDelete, @values) = (@_);

        my $connection = ConnectToMySql($database);

        my $statement = $connection->prepare($queryDelete);

	$statement->execute(@values);
}

sub GetInternalIp
{
	my $ipInterno = "";
	my ($a,$b,$c,$d) = "";
	while(my @adrs=(gethostent())[4]){
    		for my $value (@adrs) {
        		($a,$b,$c,$d) = unpack('C4',$value);
        		if($a eq 10)
        		{
                		$ipInterno = join ".", unpack('C4',$value);
        		}
    		}
	}
	
	return qq($ipInterno);

}
