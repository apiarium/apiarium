; Zone File for ncaa.com
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
		IN	NS	ns1.timewarner.net.
		IN	NS	ns5.timewarner.net.
		IN	NS	ns3.timewarner.net.
		IN	MX	None www.ncaa.com
		IN	MX	None ncaa.com
		IN	MX	None www.ncaa.com
		IN	MX	None ncaa.com
		IN	MX	None www.ncaa.com
		IN	MX	None ncaa.com
		IN	MX	None www.ncaa.com
		IN	MX	None ncaa.com
		IN	MX	None www.ncaa.com
		IN	MX	None ncaa.com
None		IN	A	157.166.248.110
None		IN	A	157.166.239.92
None		IN	A	157.166.238.29
None		IN	A	157.166.249.30
None		IN	A	157.166.238.29
None		IN	A	157.166.249.30
None		IN	A	157.166.248.110
None		IN	A	157.166.239.92
None		IN	CNAME	origin.ncaa.com.
None		IN	TXT	"ms=ms11405805"
None		IN	TXT	"ms=ms11405805"
; EOF