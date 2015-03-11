; Zone File for msnbc.com
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
		IN	NS	aus1.akam.net.
		IN	NS	eur4.akam.net.
		IN	NS	ns1-161.akam.net.
		IN	NS	usc1.akam.net.
		IN	NS	eur3.akam.net.
		IN	NS	asia3.akam.net.
		IN	NS	ns1-102.akam.net.
		IN	NS	use3.akam.net.
		IN	NS	usw1.akam.net.
		IN	MX	None msnbc.com
		IN	MX	None msnbc.com
		IN	MX	None msnbc.com
		IN	MX	None msnbc.com
None		IN	A	23.67.61.176
None		IN	A	23.67.61.146
None		IN	A	23.67.61.146
None		IN	A	23.67.61.176
None		IN	A	23.67.61.176
None		IN	A	23.67.61.146
None		IN	A	23.67.61.176
None		IN	A	23.67.61.146
None		IN	A	23.34.26.231
None		IN	A	23.202.253.53
None		IN	CNAME	groups.newsvine.com.edgesuite.net.
None		IN	CNAME	groups.newsvine.com.edgesuite.net.
None		IN	CNAME	groups.newsvine.com.edgesuite.net.
None		IN	CNAME	groups.newsvine.com.edgesuite.net.
None		IN	CNAME	msnbc.com.edgekey.net.
None		IN	TXT	"v=spf1 mx a:mx0a-00176a04.pphosted.com a:mx0b-00176a04.pphosted.com ip4:207.46.169.52/29 ip4:4.28.185.164/29 ip4:64.18.0.0/20 ip4:3.44.150.24/31 ip4:3.156.231.94/31 ip4:65.55.53.192/26 ip4:50.204.7.0/24 include:_spf-ssg-a.microsoft.com -all"
; EOF