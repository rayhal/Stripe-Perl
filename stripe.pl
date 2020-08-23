#!/usr/bin/perl

use strict;
use LWP::UserAgent;

my $SECRET_KEY="SECRET KEY GOES HERE";
my $API_KEY="API (PUBLIC) KEY GOES HERE";

sub PaymentIntent{
	my($json,$data,$stripe_url,$req,$res,$ua);
	$stripe_url="https://api.stripe.com/v1/payment_intents";
	
	# CHANGE THIS LNE TO INCLUDE YOUR ACTUAL DATA
	$data="amount=599&currency=USD&description=Test Purchase&metadata[OrderNo]=".time;

	$ua=LWP::UserAgent->new;
	$req=HTTP::Request->new(POST=>$stripe_url);
	$req->authorization_basic($SECRET_KEY,"");
	$req->content($data);
	$res=$ua->request($req);
	$json=$res->content;

	$json=~s/  //g;
	$json=~s/: /:/g;
	$json=~s/\n//g;
	
	MakePage($json);
}

sub MakePage{
	my($json,$html);
	$json=shift;

	$html=ReadFile("stripe.html");
	$html=~s/#API_KEY#/$API_KEY/;
	$html=~s/#JSON#/$json/;

	print "Content-type: text/html\n\n";
	print $html;
}

sub ReadFile{
	my($fh,$name,$text,$line);
	$name=shift;

	if(open($fh,"<",$name)){
		$text="";
		while($line=<$fh>){
			$text.=$line;}
		close($fh);
	}
	else{
		die("Cannot open ".$name);
	}
	return($text);
}
PaymentIntent();
exit;

