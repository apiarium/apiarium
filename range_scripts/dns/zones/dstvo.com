; Zone File for dstvo.com
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
		IN	NS	ns1.mweb.co.za.
		IN	NS	ns2.mweb.co.za.
		IN	MX	None dstvo.com
		IN	MX	None dstvo.com
None		IN	A	197.80.203.209
None		IN	A	197.80.203.209
None		IN	A	197.80.252.209
None		IN	A	197.80.203.28
; EOF