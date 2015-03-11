; Zone File for memset.com
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
		IN	NS	ns3.memset.com.
		IN	NS	ns1.memset.com.
		IN	NS	ns2.memset.com.
		IN	MX	None memset.com
		IN	MX	None memset.com
		IN	MX	None memset.com
None		IN	A	31.222.188.99
None		IN	A	78.31.107.87
None		IN	A	89.200.136.74
None		IN	A	37.128.131.171
None		IN	TXT	"v=spf1 a:mail.memset.com ~all"
; EOF