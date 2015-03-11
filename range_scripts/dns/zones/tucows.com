; Zone File for tucows.com
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
		IN	NS	ns2.tucows.com.
		IN	NS	ns3.tucows.com.
		IN	NS	ns1.tucows.com.
		IN	MX	None tucows.com
None		IN	A	216.40.47.20
None		IN	A	64.99.97.32
None		IN	A	216.40.47.20
None		IN	A	64.99.128.15
None		IN	TXT	"v=spf1 ip4:216.40.44.0/24 ip4:216.40.42.17/32 include:_spf.zdsys.com ?all " "google-site-verification=vR8JTNtUguZQwmRUcm7P9cGg5fHSOU_ILZ7-lz-MzMw" "MS=ms54709270"
; EOF