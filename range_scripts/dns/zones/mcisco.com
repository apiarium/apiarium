; Zone File for mcisco.com
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
		IN	NS	ns.by.com.
		IN	NS	ns2.by.com.
		IN	MX	None mcisco.com
None		IN	A	50.56.204.167
None		IN	A	37.44.190.202
; EOF