; Zone File for windowsazure.com
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
		IN	NS	ns5.msft.net.
		IN	NS	ns4.msft.net.
		IN	NS	ns2.msft.net.
		IN	NS	ns3.msft.net.
None		IN	A	65.52.200.55
None		IN	A	65.55.39.10
None		IN	A	64.4.6.100
None		IN	CNAME	www.windowsazure.com.nsatc.net.
None		IN	TXT	"v=spf1 include:_spf-ssg-a.microsoft.com -all"
None		IN	TXT	"google-site-verification=IxTcjZGG00SOzDZA0P1SyTQMf53lVfV2Yzy5YiGe1QI"
; EOF