; Zone File for amazonaws.com
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
		IN	NS	ns-1035.awsdns-01.org.
		IN	NS	ns-1735.awsdns-24.co.uk.
		IN	NS	ns-978.awsdns-58.net.
		IN	NS	ns-294.awsdns-36.com.
		IN	NS	ns-1726.awsdns-23.co.uk.
		IN	NS	ns-482.awsdns-60.com.
		IN	NS	ns-782.awsdns-33.net.
		IN	NS	ns-1084.awsdns-07.org.
		IN	NS	u2.amazonaws.com.
		IN	NS	u1.amazonaws.com.
		IN	NS	r1.amazonaws.com.
		IN	NS	r2.amazonaws.com.
		IN	MX	None amazonaws.com
		IN	MX	None amazonaws.com
		IN	MX	None amazonaws.com
		IN	MX	None amazonaws.com
		IN	MX	None amazonaws.com
None		IN	A	54.231.0.153
None		IN	A	54.231.0.176
None		IN	A	207.171.166.22
None		IN	A	72.21.210.29
None		IN	A	72.21.206.80
None		IN	A	156.154.65.10
None		IN	A	156.154.64.10
None		IN	A	205.251.192.27
None		IN	A	205.251.195.199
None		IN	CNAME	s3-directional-w.amazonaws.com.
None		IN	CNAME	s3.a-geo.amazonaws.com.
None		IN	TXT	"spf2.0/pra include:amazon.com ~all"
None		IN	TXT	"v=spf1 include:amazon.com ~all"
; EOF