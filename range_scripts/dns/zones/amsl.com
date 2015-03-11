; Zone File for amsl.com
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
		IN	NS	ns1.amsl.com.
		IN	NS	ns4.amsl.com.
		IN	NS	ns5.amsl.com.
		IN	NS	ns0.amsl.com.
		IN	MX	None amsl.com
None		IN	A	64.170.98.2
None		IN	A	4.31.198.40
None		IN	A	4.31.198.40
None		IN	A	209.208.19.199
None		IN	A	209.208.19.200
None		IN	TXT	"v=spf1 ip4:12.22.58.0/24 ip6:2001:1890:123a::/56 ip4:64.170.98.0/24 ip6:2001:1890:126c::/56 ip4:4.31.198.32/27 ip6:2001:1900:3001:0011::0/64 ip4:209.208.19.192/27 ip6:2607:f170:8000:1500::0/64 ip4:72.167.123.204 -all"
; EOF