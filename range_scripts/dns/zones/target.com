; Zone File for target.com
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
		IN	NS	ns1-168.akam.net.
		IN	NS	ns4-65.akam.net.
		IN	NS	ns7-64.akam.net.
		IN	NS	ns5-65.akam.net.
		IN	MX	None target.com
		IN	MX	None target.com
None		IN	A	23.67.61.155
None		IN	A	23.67.61.177
None		IN	A	195.59.122.42
None		IN	A	195.59.122.16
None		IN	CNAME	www.target.com.edgesuite.net.
None		IN	TXT	"v=spf1 a ptr ip4:161.225.201.20 ip4:161.225.201.21 ip4:161.225.201.22 ip4:161.225.201.23 ip4:161.225.196.20 ip4:161.225.196.21 ip4:161.225.196.22 ip4:161.225.196.23 ip4:192.237.129.78 include:wordfly.com ~all"
None		IN	TXT	"MS=ms72649311"
; EOF