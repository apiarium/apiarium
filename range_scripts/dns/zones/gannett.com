; Zone File for gannett.com
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
		IN	NS	ns1.gannett.com.
		IN	NS	usw2.akam.net.
		IN	NS	ns1-81.akam.net.
		IN	NS	use5.akam.net.
		IN	NS	ns1-160.akam.net.
		IN	NS	ns4.gannett.com.
		IN	NS	use4.akam.net.
		IN	NS	eur5.akam.net.
		IN	NS	asia4.akam.net.
		IN	NS	use2.akam.net.
		IN	NS	ns3.gannett.com.
		IN	NS	ns2.gannett.com.
		IN	MX	None gannett.com
None		IN	A	23.67.61.51
None		IN	A	23.67.61.56
None		IN	A	209.97.50.225
None		IN	A	159.54.63.153
None		IN	A	209.97.12.153
None		IN	A	159.54.158.153
None		IN	A	167.8.95.153
None		IN	CNAME	content.gannett.edgesuite.net.
None		IN	TXT	"MS=ms35676961"
None		IN	TXT	"v=spf1 ip4:159.54.39.0/24 ip4:167.8.66.0/24 include:spf.protection.outlook.com ?all"
; EOF