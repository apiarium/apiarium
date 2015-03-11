; Zone File for beyondtrust.com
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
		IN	NS	ns64.domaincontrol.com.
		IN	NS	ns63.domaincontrol.com.
		IN	MX	None www.beyondtrust.com
		IN	MX	None beyondtrust.com
None		IN	A	192.30.180.40
None		IN	A	192.30.180.40
None		IN	CNAME	beyondtrust.com.
None		IN	TXT	"v=spf1 include:aspmx.pardot.com include:spf.intermedia.net include:sendgrid.net ip4:199.87.186.0/27 ~all"
None		IN	TXT	"v=spf1 include:aspmx.pardot.com include:spf.intermedia.net include:sendgrid.net ip4:199.87.186.0/27 ~all"
; EOF