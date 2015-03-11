; Zone File for hulu.com
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
		IN	NS	use9.akam.net.
		IN	NS	asia3.akam.net.
		IN	NS	ns1-24.akam.net.
		IN	NS	asia2.akam.net.
		IN	NS	ns1-210.akam.net.
		IN	NS	usw1.akam.net.
		IN	NS	aus1.akam.net.
		IN	NS	asia1.akam.net.
		IN	MX	None hulu.com
		IN	MX	None hulu.com
None		IN	A	23.67.61.58
None		IN	A	23.67.61.66
None		IN	A	173.222.211.66
None		IN	A	173.222.211.42
None		IN	CNAME	www.hulu.com.edgesuite.net.
None		IN	TXT	"MS=ms84339951"
None		IN	TXT	"v=spf1 ip4:208.91.157.134 ip4:208.91.159.142 ip4:208.91.159.173 ip4:208.91.156.12 ip4:208.91.156.120 ptr:exghost.com ptr:appriver.com include:aspmx.googlemail.com include:mail.zendesk.com include:helpscoutemail.com -all"
; EOF