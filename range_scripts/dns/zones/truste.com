; Zone File for truste.com
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
		IN	NS	ns2.truste.com.
		IN	NS	ns1.truste.com.
		IN	MX	None truste.com
		IN	MX	None truste.com
		IN	MX	None truste.com
		IN	MX	None truste.com
		IN	MX	None truste.com
None		IN	A	54.225.183.109
None		IN	A	174.129.22.5
None		IN	A	107.21.113.241
None		IN	A	54.235.110.143
None		IN	A	54.245.247.151
None		IN	CNAME	www-55187558.us-east-1.elb.amazonaws.com.
None		IN	TXT	"v=spf1 mx a:mta.truste.com a:smtp.truste-svc.net a:www.truste.com a:netsuite.com include:mktomail.com include:_spf.google.com include:_spf.zdsys.com ~all"
; EOF