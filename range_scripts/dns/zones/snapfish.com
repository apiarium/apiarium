; Zone File for snapfish.com
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
		IN	NS	ns2.snapfish.com.
		IN	NS	ns3.snapfish.com.
		IN	MX	None snapfish.com
		IN	MX	None snapfish.com
None		IN	A	131.124.2.39
None		IN	A	131.124.0.60
None		IN	A	74.122.84.53
None		IN	A	131.124.1.10
None		IN	CNAME	www.snapfish.com.akadns.net.
None		IN	TXT	"v=spf1 a:mta.snapfish.com a:mx1asp.albumprinter.com a:mx2asp.albumprinter.com ip4:74.122.80.0/21 ip4:63.145.232.0/26 ip4:64.147.178.0/23 ip4:199.241.112.0/21 ip4:131.124.0.0/20 ip4:145.7.6.1 ip4:80.237.132.201 ~all"
None		IN	TXT	"google-site-verification=7ayY7jB7RUL_if5MYaLPkcASK0vVDEyop4MmbTgz7Dk"
None		IN	TXT	"google-site-verification=pQnBnybVB7scbCOXHt9gX2z_12cnFuDKTZiEjSEplxY"
None		IN	TXT	"google-site-verification=tC319yhQKVl2pFhuPb2KzH4LRWCbPizEdN-Yr1job54"
; EOF