; Zone File for secunia.com
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
		IN	NS	c.ns.secunia.com.
		IN	NS	b.ns.secunia.com.
		IN	NS	d.ns.secunia.com.
		IN	NS	a.ns.secunia.com.
		IN	MX	None secunia.com
		IN	MX	None secunia.com
None		IN	A	213.150.41.226
None		IN	A	91.198.117.231
None		IN	A	213.150.41.254
None		IN	A	91.198.117.232
None		IN	A	213.150.41.253
None		IN	A	213.150.41.226
None		IN	TXT	"v=spf1 ip4:91.198.117.240 ip4:213.150.41.240 mx:docusign.net -all"
; EOF