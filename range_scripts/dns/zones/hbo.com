; Zone File for hbo.com
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
		IN	NS	ns4.savvis.net.
		IN	NS	ns5.savvis.net.
		IN	NS	ns1.savvis.net.
		IN	NS	ns2.savvis.net.
		IN	NS	ns3.savvis.net.
		IN	MX	None www.hbo.com
		IN	MX	None hbo.com
		IN	MX	None www.hbo.com
		IN	MX	None hbo.com
		IN	MX	None www.hbo.com
		IN	MX	None hbo.com
		IN	MX	None www.hbo.com
		IN	MX	None hbo.com
		IN	MX	None www.hbo.com
		IN	MX	None hbo.com
		IN	MX	None www.hbo.com
		IN	MX	None hbo.com
		IN	MX	None www.hbo.com
		IN	MX	None hbo.com
		IN	MX	None www.hbo.com
		IN	MX	None hbo.com
None		IN	A	206.208.179.53
None		IN	A	206.208.179.53
None		IN	CNAME	hbo.com.
None		IN	TXT	"google-site-verification=PPKvhksy5y9BY98aJv-Pbt5KEaBx56J97MhUGW2wp90"
None		IN	TXT	"MS=ms82251557"
None		IN	TXT	"google-site-verification=kihnMTsj1roc6QOJ3MtRzKmVcznr4-J7gra1tCchVo0"
None		IN	TXT	"GM2s0rl8m2M8+aduzPSrdSx+Qov8kBguD3ScwDO3hssN091zF49gk1A7AMbBb/+XZe3Uwp06eTpym28ZmMvOmA=="
None		IN	TXT	"MS=ms82251557"
None		IN	TXT	"google-site-verification=kihnMTsj1roc6QOJ3MtRzKmVcznr4-J7gra1tCchVo0"
None		IN	TXT	"GM2s0rl8m2M8+aduzPSrdSx+Qov8kBguD3ScwDO3hssN091zF49gk1A7AMbBb/+XZe3Uwp06eTpym28ZmMvOmA=="
None		IN	TXT	"google-site-verification=PPKvhksy5y9BY98aJv-Pbt5KEaBx56J97MhUGW2wp90"
; EOF