; Zone File for netdatacenters.com
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
		IN	NS	ns2.netdatacenters.com.
		IN	NS	ns1.netdatacenters.com.
		IN	MX	None netdatacenters.com
None		IN	A	69.89.64.5
None		IN	A	65.97.49.34
None		IN	A	69.89.64.76
; EOF