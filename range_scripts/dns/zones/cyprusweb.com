; Zone File for cyprusweb.com
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
		IN	MX	None cyprusweb.com
		IN	MX	None cyprusweb.com
		IN	MX	None cyprusweb.com
		IN	MX	None cyprusweb.com
None		IN	A	205.237.127.2
None		IN	A	38.108.129.2
None		IN	TXT	"v=spf1 ip4:205.237.127.0/24 mx ~all"
; EOF