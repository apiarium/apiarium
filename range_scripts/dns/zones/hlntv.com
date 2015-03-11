; Zone File for hlntv.com
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
		IN	MX	None www.hlntv.com
		IN	MX	None hlntv.com
		IN	MX	None www.hlntv.com
		IN	MX	None hlntv.com
		IN	MX	None www.hlntv.com
		IN	MX	None hlntv.com
		IN	MX	None www.hlntv.com
		IN	MX	None hlntv.com
		IN	MX	None www.hlntv.com
		IN	MX	None hlntv.com
None		IN	A	157.166.248.134
None		IN	A	157.166.239.85
None		IN	A	157.166.248.134
None		IN	A	157.166.239.85
None		IN	CNAME	hlntv.com.
None		IN	TXT	"ms=ms12842284"
None		IN	TXT	"ms=ms12842284"
; EOF