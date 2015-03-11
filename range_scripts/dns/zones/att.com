; Zone File for att.com
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
		IN	NS	ns2.attdns.com.
		IN	NS	ns1.attdns.com.
		IN	NS	ns3.attdns.com.
		IN	NS	ns4.attdns.com.
		IN	MX	None att.com
		IN	MX	None att.com
None		IN	A	144.160.34.241
None		IN	A	172.226.233.145
None		IN	A	184.51.226.26
None		IN	A	144.160.36.42
None		IN	A	144.160.155.43
None		IN	CNAME	prod-www.zr-att.com.akadns.net.
None		IN	CNAME	www.wireless.att.com.edgekey.net.
None		IN	TXT	"MS=ms13257222"
; EOF