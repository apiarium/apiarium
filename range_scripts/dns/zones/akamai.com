; Zone File for akamai.com
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
		IN	NS	a28-66.akam.net.
		IN	NS	a3-66.akam.net.
		IN	NS	a7-66.akam.net.
		IN	NS	a13-66.akam.net.
		IN	NS	a20-66.akam.net.
		IN	NS	a1-66.akam.net.
		IN	NS	a8-66.akam.net.
		IN	NS	a12-66.akam.net.
		IN	NS	a2-66.akam.net.
		IN	NS	a5-66.akam.net.
		IN	NS	a11-66.akam.net.
		IN	NS	a16-66.akam.net.
		IN	NS	a9-66.akam.net.
		IN	MX	None akamai.com
		IN	MX	None akamai.com
		IN	MX	None akamai.com
		IN	MX	None akamai.com
None		IN	A	23.67.61.9
None		IN	A	23.67.61.19
None		IN	A	23.49.183.39
None		IN	CNAME	players.akamai.com.
; EOF