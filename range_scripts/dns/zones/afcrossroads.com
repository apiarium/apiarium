; Zone File for afcrossroads.com
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
		IN	NS	ns58.worldnic.com.
		IN	NS	ns57.worldnic.com.
		IN	MX	None afcrossroads.com
None		IN	A	184.183.183.9
None		IN	A	184.183.183.9
; EOF