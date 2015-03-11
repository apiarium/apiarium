; Zone File for attdns.com
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
		IN	NS	ns3.attdns.com.
		IN	NS	ns4.attdns.com.
		IN	NS	ns2.attdns.com.
		IN	NS	ns1.attdns.com.
		IN	MX	None attdns.com
		IN	MX	None attdns.com
None		IN	A	144.160.128.140
None		IN	A	144.160.112.22
None		IN	A	144.160.20.47
None		IN	A	144.160.229.11
; EOF