; Zone File for worldnic.com
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
		IN	NS	ns1.netsol.com.
		IN	NS	ns3.netsol.com.
		IN	NS	ns2.netsol.com.
		IN	MX	None worldnic.com
None		IN	A	206.188.198.29
None		IN	A	207.204.40.129
None		IN	A	207.204.40.134
None		IN	A	206.188.198.34
None		IN	A	205.178.187.13
None		IN	A	207.204.40.114
None		IN	A	206.188.198.14
; EOF