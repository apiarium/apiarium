; Zone File for live.com
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
		IN	NS	ns2.msft.net.
		IN	NS	ns4.msft.net.
		IN	NS	ns1.msft.net.
		IN	NS	ns3.msft.net.
		IN	MX	None live.com
		IN	MX	None live.com
		IN	MX	None live.com
		IN	MX	None live.com
None		IN	A	131.253.61.68
None		IN	A	131.253.61.80
None		IN	A	131.253.61.96
None		IN	A	131.253.61.98
None		IN	A	65.55.206.154
None		IN	CNAME	login.live.com.nsatc.net.
None		IN	TXT	"v=spf1 include:spf-a.hotmail.com include:spf-b.hotmail.com include:spf-c.hotmail.com include:spf-d.hotmail.com include:_spf-ssg-a.microsoft.com ~all"
None		IN	TXT	"google-site-verification=9Jd_bwLm0HB1LU1v4FHK7ztlJxnE1QpbJxmwICkmWgk"
; EOF