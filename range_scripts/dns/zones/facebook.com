; Zone File for facebook.com
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
		IN	NS	b.ns.facebook.com.
		IN	NS	a.ns.facebook.com.
		IN	MX	None developers.facebook.com
		IN	MX	None www.facebook.com
		IN	MX	None facebook.com
None		IN	A	31.13.65.49
None		IN	A	31.13.65.49
None		IN	A	173.252.120.6
None		IN	A	69.171.255.12
None		IN	A	69.171.239.12
None		IN	CNAME	star.facebook.com.
None		IN	CNAME	star.c10r.facebook.com.
None		IN	TXT	"v=spf1 redirect=_spf.facebook.com"
; EOF