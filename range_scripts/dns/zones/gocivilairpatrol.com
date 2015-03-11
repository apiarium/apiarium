; Zone File for gocivilairpatrol.com
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
		IN	NS	ns1.cyprusweb.com.
		IN	NS	ns2.cyprusweb.com.
		IN	MX	None gocivilairpatrol.com
		IN	MX	None www.gocivilairpatrol.com
None		IN	A	205.237.127.107
None		IN	A	205.237.127.107
None		IN	CNAME	gocivilairpatrol.com.
None		IN	TXT	"v=spf1 -all"
None		IN	TXT	"v=spf1 -all"
; EOF