; Zone File for microsoft.com
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
		IN	NS	ns1.msft.net.
		IN	NS	ns4.msft.net.
		IN	NS	ns2.msft.net.
		IN	NS	ns3.msft.net.
		IN	MX	None microsoft.com
None		IN	A	65.55.56.209
None		IN	A	157.56.148.40
None		IN	A	65.55.227.140
None		IN	A	65.52.57.5
None		IN	A	23.67.61.179
None		IN	A	23.67.61.178
None		IN	A	157.56.75.164
None		IN	A	138.91.120.11
None		IN	A	134.170.48.192
None		IN	A	157.56.148.41
None		IN	A	134.170.119.140
None		IN	A	172.226.239.165
None		IN	A	134.170.185.46
None		IN	A	134.170.188.221
None		IN	CNAME	careers.microsoft.akadns.net.
None		IN	CNAME	msdn.microsoft.akadns.net.
None		IN	CNAME	office.glbdns2.microsoft.com.
None		IN	CNAME	msit-pur.cloudapp.net.
None		IN	CNAME	search.microsoft.akadns.net.
None		IN	CNAME	lb.social.ms.akadns.net.
None		IN	CNAME	smc-live-fe.trafficmanager.net.
None		IN	CNAME	pinpoint.microsoft.com.cp.microsoft.com.nsatc.net.
None		IN	CNAME	technet.microsoft.akadns.net.
None		IN	CNAME	origin.windows.microsoft.com.akadns.net.
None		IN	CNAME	toggle.www.ms.akadns.net.
None		IN	TXT	"v=spf1 include:_spf-a.microsoft.com include:_spf-b.microsoft.com include:_spf-c.microsoft.com include:_spf-ssg-a.microsoft.com include:spf-a.hotmail.com ip4:147.243.128.24 ip4:147.243.128.26 ip4:147.243.128.25 ip4:147.243.1.47 ip4:147.243.1.48 -all"
None		IN	TXT	"FbUF6DbkE+Aw1/wi9xgDi8KVrIIZus5v8L6tbIQZkGrQ/rVQKJi8CjQbBtWtE64ey4NJJwj5J65PIggVYNabdQ=="
; EOF