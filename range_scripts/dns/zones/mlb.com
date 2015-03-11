; Zone File for mlb.com
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
		IN	NS	ns2.p38.dynect.net.
		IN	NS	ns1.p38.dynect.net.
		IN	NS	ns4.p38.dynect.net.
		IN	NS	ns3.p38.dynect.net.
		IN	MX	None mlb.com
		IN	MX	None mlb.com
None		IN	A	23.67.61.163
None		IN	A	23.67.61.168
None		IN	A	209.102.210.73
None		IN	A	209.102.210.73
None		IN	CNAME	mlb.mlb.com.edgesuite.net.
None		IN	TXT	"v=spf1 ip4:66.192.34.0/24 ip4:63.240.7.0/24 ip4:63.240.10.0/24 ip4:66.192.34.0/24 ip4:12.130.102.0/24 ip4:206.18.120.0/24 ip4:216.154.234.0/24 ip4:206.16.207.17 ip4:64.95.235.125 ip4:204.250.77.0/24 ip4:209.102.210.0/23 ip4:209.102.212.0/24 mx -all"
; EOF