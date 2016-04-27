#!/usr/bin/perl
use strict;
use warnings;
use LWP::UserAgent;
use LWP::Protocol::https;
use MIME::Base64;
use XML::Simple;
use Data::Dumper;
use Encode qw(decode encode);
use Sys::Hostname;

my $bkpStatus = shift;

#Define parametros para autenticacao no servidor, para utilizacao da API
#cpweb
#my $user = "user";
#my $pass = 'password';

#d3-revlin-stg1
my $user = "root";
my $pass = 'sun123';

my $auth = "Basic " . MIME::Base64::encode( $user . ":" . $pass );

my $ua = LWP::UserAgent->new(
    ssl_opts   => { verify_hostname => 0, SSL_verify_mode => 'SSL_VERIFY_NONE', SSL_use_cert => 0 },
);
my $machine = "d3-revlin-stg1";
print $machine . "\n";

#cpweb
#my $request = HTTP::Request->new( GET => "http://$machine:2086/xml-api/get_featurelist_data?api.version=1&featurelist=uh-padrao1" );

#d3-revlin-stg1
my $request = HTTP::Request->new( GET => "http://$machine:2086/xml-api/get_featurelist_data?api.version=1&featurelist=default" );
$request->header( Authorization => $auth );
my $response = $ua->request($request);
my $data = XMLin($response->content);
my $features= "";

foreach my $key (keys (%{$data->{data}->{features}}))
{
        my %currentHash = (%{$data->{data}->{features}});
        my $value = $currentHash{$key}->{'value'};

        if($key eq "backup" || $key eq "backupwizard"){
                $features .= $key . "=$bkpStatus&";
        }else{
                $features .= $key  . "=" . $value . "&";
        }
}

my $updateRequestString = "http://$machine:2086/xml-api/update_featurelist?api.version=1&featurelist=default&" . $features;

$request = HTTP::Request->new( GET => $updateRequestString );
$request->header( Authorization => $auth );
$response = $ua->request($request);
$data = XMLin($response->content);

foreach my $key (keys %{$data->{data}->{updated_features}})
{
        print $key . " ";
        my %currentHash = (%{$data->{data}->{updated_features}});
        if ( $currentHash{$key} eq 1 )
        {
                print "= ativado;\n";
        }
        else
        {
                print "= desativado;\n";
        }


}
