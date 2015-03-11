; Zone File for onegreatserver.com
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
		IN	NS	ns.onegreatserver.com.
		IN	NS	ns2.onegreatserver.com.
		IN	MX	None onegreatserver.com
None		IN	A	208.43.246.234
None		IN	A	208.43.246.234
None		IN	A	208.43.246.234
; EOF