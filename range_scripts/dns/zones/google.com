; Zone File for google.com
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
		IN	NS	ns1.google.com.
		IN	NS	ns4.google.com.
		IN	NS	ns3.google.com.
		IN	NS	ns2.google.com.
		IN	MX	None google.com
		IN	MX	None google.com
		IN	MX	None google.com
		IN	MX	None google.com
		IN	MX	None google.com
None		IN	A	64.233.185.100
None		IN	A	64.233.185.139
None		IN	A	64.233.185.113
None		IN	A	64.233.185.138
None		IN	A	64.233.185.102
None		IN	A	64.233.185.101
None		IN	A	173.194.76.104
None		IN	A	173.194.76.103
None		IN	A	173.194.76.147
None		IN	A	173.194.76.99
None		IN	A	173.194.76.105
None		IN	A	173.194.76.106
None		IN	A	64.233.185.113
None		IN	A	64.233.185.138
None		IN	A	64.233.185.102
None		IN	A	64.233.185.101
None		IN	A	64.233.185.100
None		IN	A	64.233.185.139
None		IN	A	64.233.185.104
None		IN	A	64.233.185.147
None		IN	A	64.233.185.106
None		IN	A	64.233.185.99
None		IN	A	64.233.185.103
None		IN	A	64.233.185.105
None		IN	A	64.233.185.113
None		IN	A	64.233.185.102
None		IN	A	64.233.185.138
None		IN	A	64.233.185.139
None		IN	A	64.233.185.100
None		IN	A	64.233.185.101
None		IN	A	216.239.36.10
None		IN	A	216.239.32.10
None		IN	A	216.239.38.10
None		IN	A	216.239.34.10
None		IN	A	64.233.185.100
None		IN	A	64.233.185.102
None		IN	A	64.233.185.138
None		IN	A	64.233.185.113
None		IN	A	64.233.185.139
None		IN	A	64.233.185.101
None		IN	CNAME	www3.l.google.com.
None		IN	CNAME	scholar.l.google.com.
None		IN	CNAME	www3.l.google.com.
None		IN	TXT	"v=spf1 include:_spf.google.com ip4:216.73.93.70/31 ip4:216.73.93.72/31 ~all"
; EOF