; Zone File for paloalto.com
; Generated Wed Mar 11 14:36:06 2015
$TTL 172800
$ORIGIN None
@		IN	SOA	  (
			  3h
			  3h
			  15m
			  1w
			  1d
			  )
		IN	NS	ns-887.awsdns-46.net.
		IN	NS	ns-135.awsdns-16.com.
		IN	NS	ns-1949.awsdns-51.co.uk.
		IN	NS	ns-1031.awsdns-00.org.
		IN	MX	None paloalto.com
		IN	MX	None paloalto.com
		IN	MX	None paloalto.com
		IN	MX	None paloalto.com
None		IN	A	54.236.158.111
None		IN	A	54.165.164.78
None		IN	A	54.236.158.111
None		IN	A	54.165.164.78
None		IN	CNAME	lapinvpc-1982570052.us-east-1.elb.amazonaws.com.
None		IN	TXT	"include:emailcenterpro.com include:_spf.google.com include:spf.mailengine1.com ~all"
None		IN	TXT	"include:support.zendesk.com include:smtp.zendesk.com ~all"
None		IN	TXT	"google-site-verification=vU-y8wG4cpMPcUaNFxxW5OjQUzUbuUMPuMlyT_zZn14 ~all"
; EOF