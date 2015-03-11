; Zone File for tenable.com
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
		IN	NS	ns4.tenablesecurity.com.
		IN	NS	ns7.tenablesecurity.com.
		IN	NS	ns8.tenablesecurity.com.
		IN	NS	ns6.tenablesecurity.com.
		IN	MX	None tenable.com
		IN	MX	None tenable.com
		IN	MX	None tenable.com
None		IN	A	4.59.136.200
None		IN	A	4.59.136.200
None		IN	TXT	"v=spf1 ip4:4.59.136.192/26 ip4:4.79.179.64/27 ip4:63.148.88.0/24 include:mktomail.com mx ?all"
; EOF