; Zone File for server278.com
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
		IN	NS	ns1.server278.com.
		IN	NS	ns2.server278.com.
		IN	MX	None server278.com
None		IN	A	64.14.68.66
None		IN	A	64.14.68.65
None		IN	A	64.14.68.65
; EOF