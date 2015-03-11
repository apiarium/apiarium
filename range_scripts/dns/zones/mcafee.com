; Zone File for mcafee.com
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
		IN	NS	usw4.akam.net.
		IN	NS	ns1-2.akam.net.
		IN	NS	ns-a.mcafee.com.
		IN	NS	usw5.akam.net.
		IN	NS	ns-b.mcafee.com.
		IN	NS	use4.akam.net.
		IN	NS	usc3.akam.net.
		IN	MX	None mcafee.com
		IN	MX	None mcafee.com
		IN	MX	None mcafee.com
		IN	MX	None mcafee.com
None		IN	A	172.226.231.54
None		IN	A	161.69.29.243
None		IN	A	216.49.88.14
None		IN	A	208.69.152.14
None		IN	CNAME	www.mcafee.com.edgekey.net.
None		IN	TXT	"zwGBphgWKY+BMz0gP3/dX8S1eJLSMIUpTY/7lKdKG99TwB5iB3QYXofZAbGB4B1bo+SxJlj1e4dAKgW2hYhg/A=="
None		IN	TXT	"v=spf1 ip4:205.227.128.0/20 ip4:205.227.136.0/24 ip4:67.97.80.0/20 ip4:161.69.0.0/16 ip4:216.49.92.0/24 ip4:192.187.128.0/24 -all"
; EOF