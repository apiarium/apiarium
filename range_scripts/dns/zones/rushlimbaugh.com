; Zone File for rushlimbaugh.com
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
		IN	NS	usw4.akam.net.
		IN	NS	usw2.akam.net.
		IN	NS	usc1.akam.net.
		IN	NS	ns1-206.akam.net.
		IN	NS	ns1-89.akam.net.
		IN	NS	use1.akam.net.
		IN	MX	None rushlimbaugh.com
		IN	MX	None rushlimbaugh.com
None		IN	A	23.67.61.192
None		IN	A	23.67.61.163
None		IN	A	216.52.227.11
None		IN	CNAME	www.rushlimbaugh.com.edgesuite.net.
None		IN	TXT	"b3gj9mw"
; EOF