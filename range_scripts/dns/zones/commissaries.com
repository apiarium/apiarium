; Zone File for commissaries.com
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
		IN	NS	ns2.commissaries.com.
		IN	NS	ns1.commissaries.com.
		IN	MX	None commissaries.com
		IN	MX	None commissaries.com
None		IN	A	65.125.15.196
None		IN	A	65.125.15.196
None		IN	A	65.115.69.2
None		IN	A	65.125.15.195
; EOF