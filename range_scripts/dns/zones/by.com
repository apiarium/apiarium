; Zone File for by.com
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
		IN	NS	dns2.subnett.no.
		IN	NS	dns.subnett.no.
		IN	MX	None by.com
		IN	MX	None by.com
None		IN	A	70.85.129.159
None		IN	A	37.44.190.205
None		IN	A	98.129.229.234
; EOF