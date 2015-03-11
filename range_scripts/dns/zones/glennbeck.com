; Zone File for glennbeck.com
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
		IN	NS	ns1-206.akam.net.
		IN	NS	usw2.akam.net.
		IN	NS	usc1.akam.net.
		IN	NS	use1.akam.net.
		IN	NS	usw4.akam.net.
		IN	NS	ns1-125.akam.net.
		IN	NS	ns1-174.akam.net.
		IN	NS	ns1-89.akam.net.
		IN	MX	None glennbeck.com
None		IN	A	23.67.61.185
None		IN	A	23.67.61.160
None		IN	A	216.52.227.11
None		IN	CNAME	www.glennbeck.com.edgesuite.net.
None		IN	TXT	"v=spf1 ip4:66.161.21.0/24 ip4:24.38.56.0/22 ip4:74.201.66.0/24 ip4:74.201.67.0/24 ip4:74.201.68.0/24 ip4:69.174.85.0/24 ip4:8.22.32.0/20 ip4:216.52.227.0/24 include:aspmx.sailthru.com include:spf.protection.outlook.com ~all"
; EOF