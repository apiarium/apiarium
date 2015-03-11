; Zone File for twitter.com
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
		IN	NS	ns3.p34.dynect.net.
		IN	NS	ns4.p34.dynect.net.
		IN	NS	ns2.p34.dynect.net.
		IN	NS	ns1.p34.dynect.net.
		IN	MX	None twitter.com
		IN	MX	None www.twitter.com
		IN	MX	None twitter.com
		IN	MX	None www.twitter.com
		IN	MX	None twitter.com
		IN	MX	None www.twitter.com
		IN	MX	None twitter.com
		IN	MX	None www.twitter.com
		IN	MX	None twitter.com
		IN	MX	None www.twitter.com
None		IN	A	199.16.156.6
None		IN	A	199.16.156.198
None		IN	A	199.16.156.230
None		IN	A	199.16.156.102
None		IN	A	199.59.148.10
None		IN	A	199.59.149.230
None		IN	A	199.59.148.82
None		IN	A	199.59.150.39
None		IN	CNAME	twitter.com.
None		IN	TXT	"v=spf1 ip4:199.16.156.0/22 ip4:199.59.148.0/22 ip4:8.25.194.0/23 ip4:8.25.196.0/23 ip4:204.92.114.203 ip4:204.92.114.204/31 ip4:107.20.52.15 ip4:23.21.83.90 include:_spf.google.com include:_thirdparty.twitter.com -all"
None		IN	TXT	"v=spf1 ip4:199.16.156.0/22 ip4:199.59.148.0/22 ip4:8.25.194.0/23 ip4:8.25.196.0/23 ip4:204.92.114.203 ip4:204.92.114.204/31 ip4:107.20.52.15 ip4:23.21.83.90 include:_spf.google.com include:_thirdparty.twitter.com -all"
; EOF