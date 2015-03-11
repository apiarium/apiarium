; Zone File for googleapis.com
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
		IN	NS	ns3.google.com.
		IN	NS	ns1.google.com.
		IN	NS	ns4.google.com.
		IN	NS	ns2.google.com.
None		IN	A	64.233.185.95
None		IN	A	64.233.185.147
None		IN	A	64.233.185.99
None		IN	A	64.233.185.104
None		IN	A	64.233.185.105
None		IN	A	64.233.185.106
None		IN	A	64.233.185.103
None		IN	CNAME	googleapis.l.google.com.
; EOF