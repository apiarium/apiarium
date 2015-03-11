; Zone File for theblaze.com
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
		IN	NS	ns1-174.akam.net.
		IN	NS	ns1-125.akam.net.
		IN	NS	usc1.akam.net.
		IN	NS	usw4.akam.net.
		IN	NS	usw2.akam.net.
		IN	NS	use1.akam.net.
		IN	NS	ns1-89.akam.net.
		IN	NS	ns1-206.akam.net.
		IN	MX	None theblaze.com
None		IN	A	204.160.125.254
None		IN	A	8.12.206.253
None		IN	A	192.221.96.253
None		IN	A	216.239.34.21
None		IN	A	216.239.38.21
None		IN	A	216.239.32.21
None		IN	A	216.239.36.21
None		IN	CNAME	www.video.theblaze.com.c.footprint.net.
None		IN	TXT	"v=spf1 ip4:216.185.156.0/22 ip4:209.85.219.0/24 include:_spf.google.com include:aus.us.siteprotect.com include:spf.protection.outlook.com include:aspmx.sailthru.com ~all"
; EOF