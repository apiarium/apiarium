; Zone File for psg.com
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
		IN	NS	rip.psg.com.
		IN	NS	nlns.globnix.net.
		IN	NS	psg.com.
		IN	MX	None rip.psg.com
		IN	MX	None psg.com
		IN	MX	None psg.com
None		IN	A	147.28.0.39
None		IN	A	147.28.0.62
None		IN	A	147.28.0.62
None		IN	TXT	"v=spf1 ip4:147.28.0.0/16 ipv4:198.180.150.0/24 ipv4:198.180.152.0/24 ip6:2001:418:1::0/64 ipv6:2001:418:8006::0/64 ipv6:2001:418:3807 a ptr ~all"
None		IN	TXT	"v=spf1 ip4:147.28.0.0/16 ipv4:198.180.150.0/24 ipv4:198.180.152.0/24 ip6:2001:418:1::0/64 ipv6:2001:418:8006::0/64 ipv6:2001:418:3807 a ptr ~all"
; EOF