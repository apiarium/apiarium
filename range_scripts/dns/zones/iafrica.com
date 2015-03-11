; Zone File for iafrica.com
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
		IN	NS	ns1.iafrica.com.
		IN	NS	ns2.iafrica.com.
		IN	NS	rip.psg.com.
		IN	MX	None ns1.iafrica.com
		IN	MX	None ns2.iafrica.com
		IN	MX	None iafrica.com
None		IN	A	196.7.142.131
None		IN	A	23.23.127.42
None		IN	A	196.7.0.139
None		IN	A	196.7.142.133
; EOF