; Zone File for th1n.com
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
		IN	NS	ns1.mediatemple.net.
		IN	NS	ns2.mediatemple.net.
		IN	MX	None th1n.com
None		IN	A	64.207.139.207
; EOF