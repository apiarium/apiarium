; Zone File for ericy.com
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
		IN	NS	e3dns2.ericy.com.
		IN	NS	e3dns.ericy.com.
		IN	NS	ns1.ericsson.se.
		IN	MX	None ericy.com
		IN	MX	None ericy.com
		IN	MX	None ericy.com
		IN	MX	None ericy.com
None		IN	A	198.24.6.2
None		IN	A	198.24.6.4
; EOF