#!/usr/bin/perl
use strict;
use warnings;
use DBI;
use DBD::mysql;

my $database = "gateway_email";

my $connection = ConnectToMySql($database);

my $querySelect = "
SELECT d.idt_domain, d.des_domain, s.des_status
FROM central_domain d
 INNER JOIN     central_status s
 ON d.idt_status = s.idt_status
WHERE d.des_domain = \'lucasftp.com\'";
my $statement = $connection->prepare($querySelect);

$statement->execute();

my @data = $statement->fetchrow_array();

my $idt_domain = $data[0];

my $des_domain = $data[1];

my $idt_status = $data[2];

print "ID Domain: " . $idt_domain;
print "\nDes Domain: " . $des_domain;
print "\nID Status: " . $idt_status. "\n";

exit;

sub ConnectToMySql
{
        my ($db) = @_;

        #Open the accessDB file to retrieve the database name, host name, user name, and password
        open(ACCESS_INFO, "<.\/accessDB") || die "Can't access login credentials";

        #Assign the values in the accessDB file to the variables
        my $database = <ACCESS_INFO>;
        my $host = <ACCESS_INFO>;
        my $userid = <ACCESS_INFO>;
        my $passwd = <ACCESS_INFO>;

        print "\n".$database."\n".$host."\n".$userid."\n".$passwd."\n";

        #Assign the values to the connection variable
        my $connectionInfo = "dbi:mysql:$db:$host";

        close(ACCESS_INFO);

        chomp($database, $host, $userid, $passwd);

        my $l_connection = DBI->connect($connectionInfo,$userid,$passwd);

        #The value of this connection is returned by the sub-routine
        return $l_connection;
}

#Sample of the accessDB file:
# my_database
# 192.168.1.1
# user_dbadmin
# passwd123*
