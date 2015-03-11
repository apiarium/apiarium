; Zone File for go.com
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
		IN	NS	orns01.dig.com.
		IN	NS	sens02.dig.com.
		IN	NS	sens01.dig.com.
		IN	NS	orns02.dig.com.
		IN	MX	None go.com
None		IN	A	199.181.133.61
None		IN	A	199.181.131.249
None		IN	CNAME	espn.gns.go.com.
; EOF