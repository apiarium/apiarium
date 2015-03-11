; Zone File for cinemax.com
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
		IN	NS	ns3.savvis.net.
		IN	NS	ns1.savvis.net.
		IN	NS	ns5.savvis.net.
		IN	NS	ns2.savvis.net.
		IN	NS	ns4.savvis.net.
		IN	MX	None www.cinemax.com
		IN	MX	None cinemax.com
		IN	MX	None www.cinemax.com
		IN	MX	None cinemax.com
		IN	MX	None www.cinemax.com
		IN	MX	None cinemax.com
		IN	MX	None www.cinemax.com
		IN	MX	None cinemax.com
		IN	MX	None www.cinemax.com
		IN	MX	None cinemax.com
		IN	MX	None www.cinemax.com
		IN	MX	None cinemax.com
None		IN	A	206.208.183.102
None		IN	A	206.208.183.102
None		IN	CNAME	cinemax.com.
; EOF