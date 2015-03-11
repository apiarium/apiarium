; Zone File for systemdns.com
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
		IN	NS	ns2.tucows.com.
		IN	NS	ns3.tucows.com.
		IN	NS	ns1.tucows.com.
None		IN	A	216.40.47.90
None		IN	A	216.40.47.90
None		IN	A	64.99.96.36
None		IN	A	216.40.33.15
; EOF