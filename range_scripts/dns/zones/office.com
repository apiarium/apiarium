; Zone File for office.com
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
		IN	NS	ns2.msedge.net.
		IN	NS	ns3.msedge.net.
		IN	NS	ns4.msedge.net.
		IN	NS	ns1.msedge.net.
None		IN	A	64.4.6.100
None		IN	A	65.55.39.10
None		IN	A	134.170.27.81
None		IN	A	134.170.170.81
None		IN	A	134.170.48.17
None		IN	A	134.170.128.209
None		IN	A	134.170.65.81
; EOF