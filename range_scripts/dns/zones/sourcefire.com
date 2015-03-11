; Zone File for sourcefire.com
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
		IN	NS	ns-561.awsdns-06.net.
		IN	NS	ns-1472.awsdns-56.org.
		IN	NS	ns-243.awsdns-30.com.
		IN	NS	ns-1820.awsdns-35.co.uk.
		IN	MX	None www.sourcefire.com
		IN	MX	None sourcefire.com
		IN	MX	None www.sourcefire.com
		IN	MX	None sourcefire.com
		IN	MX	None www.sourcefire.com
		IN	MX	None sourcefire.com
		IN	MX	None www.sourcefire.com
		IN	MX	None sourcefire.com
None		IN	A	54.243.76.201
None		IN	A	50.16.246.117
None		IN	CNAME	sourcefire.com.
None		IN	TXT	"v=spf1 include:spf.sourcefire.com include:mktomail.com include:sendgrid.net ~all"
None		IN	TXT	"v=spf1 include:spf.sourcefire.com include:mktomail.com include:sendgrid.net ~all"
; EOF