; Zone File for supersport.com
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
		IN	NS	ns2.dstvo.com.
		IN	NS	ns1.dstvo.com.
		IN	NS	ns3.dstvo.com.
		IN	MX	None supersport.com
		IN	MX	None supersport.com
None		IN	A	196.28.29.193
None		IN	A	197.80.203.245
None		IN	CNAME	dstv-ss.gslb.info.
; EOF