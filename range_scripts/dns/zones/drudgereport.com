; Zone File for drudgereport.com
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
		IN	NS	ns3.ha-hosting.com.
		IN	NS	ns2.ha-hosting.com.
		IN	NS	ns4.ha-hosting.com.
		IN	NS	ns1.ha-hosting.com.
		IN	MX	None www.drudgereport.com
		IN	MX	None drudgereport.com
		IN	MX	None www.drudgereport.com
		IN	MX	None drudgereport.com
None		IN	A	98.158.27.203
None		IN	A	98.158.27.203
None		IN	CNAME	drudgereport.com.
; EOF