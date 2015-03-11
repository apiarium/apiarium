; Zone File for nfl.com
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
		IN	NS	asia9.akam.net.
		IN	NS	ns1-87.akam.net.
		IN	NS	eur3.akam.net.
		IN	NS	asia1.akam.net.
		IN	NS	ns1-178.akam.net.
		IN	NS	use4.akam.net.
		IN	NS	usc1.akam.net.
		IN	NS	asia3.akam.net.
		IN	MX	None nfl.com
None		IN	A	192.0.83.250
None		IN	A	66.155.11.244
None		IN	A	66.155.9.244
None		IN	A	76.74.255.123
None		IN	A	76.74.255.117
None		IN	A	192.0.82.250
None		IN	A	54.85.145.199
None		IN	A	54.85.166.63
None		IN	A	192.0.82.250
None		IN	A	192.0.83.250
None		IN	A	66.155.11.244
None		IN	A	66.155.9.244
None		IN	A	76.74.255.123
None		IN	A	76.74.255.117
None		IN	A	23.67.61.200
None		IN	A	23.67.61.147
None		IN	A	23.15.8.49
None		IN	A	23.15.8.26
None		IN	CNAME	nfldavedameshek.wordpress.com.
None		IN	CNAME	vpc-multiaz03-345068270.us-east-1.elb.amazonaws.com.
None		IN	CNAME	nflricheisen.wordpress.com.
None		IN	CNAME	www.nfl.com.edgesuite.net.
None		IN	TXT	"MS=ms18024666"
; EOF