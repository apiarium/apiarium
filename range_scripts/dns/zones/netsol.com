; Zone File for netsol.com
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
		IN	NS	ns2.netsol.com.
		IN	NS	ns3.netsol.com.
		IN	NS	ns1.netsol.com.
		IN	MX	None netsol.com
None		IN	A	209.17.114.135
None		IN	A	209.17.114.135
None		IN	A	209.17.114.135
None		IN	A	205.178.187.13
; EOF