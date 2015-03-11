; Zone File for microsoftbusinesshub.com
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
		IN	NS	ns4.msft.net.
		IN	NS	ns1.msft.net.
		IN	NS	ns2.msft.net.
		IN	NS	ns5.msft.net.
		IN	NS	ns3.msft.net.
None		IN	A	157.55.208.74
None		IN	A	157.55.208.74
None		IN	CNAME	smb.cloudapp.net.
; EOF