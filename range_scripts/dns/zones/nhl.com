; Zone File for nhl.com
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
		IN	NS	eur2.akam.net.
		IN	NS	usw6.akam.net.
		IN	NS	ns1-47.akam.net.
		IN	NS	usw5.akam.net.
		IN	NS	ns1-33.akam.net.
		IN	NS	usw1.akam.net.
		IN	MX	None nhl.com
		IN	MX	None nhl.com
None		IN	A	23.67.61.178
None		IN	A	23.67.61.169
None		IN	A	8.20.73.150
None		IN	CNAME	www.nhl.com.edgesuite.net.
; EOF