; Zone File for timecubed.com
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
		IN	NS	ns3.memset.com.
		IN	NS	ns2.memset.com.
		IN	NS	ns1.memset.com.
		IN	MX	None www.timecubed.com
		IN	MX	None timecubed.com
None		IN	A	31.25.187.153
None		IN	A	31.25.187.153
None		IN	CNAME	timecubed.com.
; EOF