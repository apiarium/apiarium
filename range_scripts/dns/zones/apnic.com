; Zone File for apnic.com
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
		IN	NS	sec1.authdns.ripe.net.
		IN	NS	sec3.apnic.com.
		IN	NS	ns4.apnic.net.
		IN	NS	ns3.apnic.net.
		IN	NS	sec1.apnic.com.
		IN	NS	ns1.apnic.net.
		IN	NS	sec2.apnic.com.
		IN	MX	None apnic.com
		IN	MX	None apnic.com
		IN	MX	None apnic.com
None		IN	A	202.12.31.140
None		IN	A	202.12.29.205
None		IN	A	202.12.28.140
None		IN	A	202.12.29.59
None		IN	A	202.12.29.60
None		IN	TXT	"v=spf1 mx -all"
; EOF