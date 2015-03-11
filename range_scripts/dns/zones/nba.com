; Zone File for nba.com
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
		IN	NS	ns60.nba.com.
		IN	NS	ns40.nba.com.
		IN	NS	ns50.nba.com.
		IN	MX	None nba.com
		IN	MX	None nba.com
		IN	MX	None nba.com
		IN	MX	None nba.com
None		IN	A	66.155.9.244
None		IN	A	76.74.255.123
None		IN	A	76.74.255.117
None		IN	A	192.0.82.250
None		IN	A	192.0.83.250
None		IN	A	66.155.11.244
None		IN	A	63.236.106.158
None		IN	A	23.67.61.193
None		IN	A	23.67.61.153
None		IN	A	50.31.158.88
None		IN	A	23.67.61.185
None		IN	A	23.67.61.146
None		IN	A	157.166.249.247
None		IN	A	157.166.248.245
None		IN	A	209.133.83.36
None		IN	A	66.6.224.59
None		IN	A	66.6.226.59
None		IN	CNAME	turnernbaallball.wordpress.com.
None		IN	CNAME	d4.parature.com.
None		IN	CNAME	stats.nba.com.edgesuite.net.
None		IN	CNAME	store.nba.com.fanaticsretailgroup.com.
None		IN	CNAME	www.nba.com.edgesuite.net.
None		IN	TXT	"y+Yve/Gk3nXCvgVrzwtWkswd/e4v0vQZ5bwsriDDYRc7ScOg7STUzGWRMy7K+uRyEYDLV/LldJkS9OYnlEvW3w=="
None		IN	TXT	"MS=ms15146138"
None		IN	TXT	"v=spf1 mx ip4:66.6.224.40/31 ip4:66.6.224.42/32 ip4:66.6.226.58/32 ip4:209.133.83.34/32" " ip4:66.6.224.78/32 ip4:66.6.224.71/32 ip4:66.6.224.72/32 ip4:66.6.224.74/32 ip4:66.6.226.16/31" " ip4:66.6.226.18/32 ip4:222.126.195.238/32 ip4:203.192.156.55/32 ip4:222.126.195.237/32 ip4:62.84.172.7/32 include:customers.clickdimensions.com include:spf1.worldapp.com -all"
; EOF