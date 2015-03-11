; Zone File for verisigndns.com
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
		IN	NS	a2.verisigndns.com.
		IN	NS	u1.verisigndns.com.
		IN	NS	a1.verisigndns.com.
		IN	NS	u3.verisigndns.com.
		IN	NS	u2.verisigndns.com.
		IN	NS	a3.verisigndns.com.
None		IN	A	209.112.113.33
None		IN	A	209.112.114.33
None		IN	A	69.36.145.33
None		IN	A	69.58.186.114
None		IN	A	209.112.113.33
None		IN	A	69.36.145.33
None		IN	A	209.112.114.33
; EOF