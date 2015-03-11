; Zone File for windowsphone.com
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
		IN	NS	ns2.msft.net.
		IN	NS	ns1.msft.net.
		IN	NS	ns3.msft.net.
None		IN	A	157.55.80.128
None		IN	A	207.46.1.137
None		IN	CNAME	www.windowsphone.com.akadns.net.
None		IN	TXT	"v=spf1 include:_spf-ssg-a.microsoft.com"
None		IN	TXT	"google-site-verification=km1tX1fpwnigS46YbXLBleBO15eqHRgC-DzDUw3Esvo"
; EOF