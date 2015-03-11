; Zone File for netflix.com
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
		IN	NS	pdns89.ultradns.net.
		IN	NS	pdns89.ultradns.com.
		IN	NS	pdns89.ultradns.org.
		IN	NS	pdns89.ultradns.biz.
		IN	MX	None netflix.com
		IN	MX	None netflix.com
		IN	MX	None netflix.com
		IN	MX	None netflix.com
		IN	MX	None netflix.com
None		IN	A	50.16.226.125
None		IN	A	50.19.122.248
None		IN	A	107.21.234.213
None		IN	A	54.214.239.222
None		IN	A	54.203.247.23
None		IN	A	69.53.236.17
None		IN	CNAME	help.us-west-2.netflix.com.
None		IN	CNAME	signup.us-west-2.netflix.com.
None		IN	CNAME	www.us-west-2.netflix.com.
None		IN	TXT	"v=spf1 ip4:69.53.224.0/19 ip4:165.193.233.164/30 ip4:205.139.44.20 ip4:66.150.112.120 ip4:205.139.45.20 ip4:209.177.164.2 ip4:54.84.21.177 ip4:54.85.33.189 include:_spf.google.com include:amazonses.com -all"
; EOF