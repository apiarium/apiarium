; Zone File for capvolunteernow.com
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
		IN	NS	ns2.cyprusweb.com.
		IN	NS	ns1.cyprusweb.com.
None		IN	A	205.237.127.107
None		IN	A	205.237.127.107
None		IN	CNAME	capvolunteernow.com.
None		IN	TXT	"v=spf1 -all"
None		IN	TXT	"v=spf1 -all"
; EOF