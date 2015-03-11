; Zone File for levkowetz.com
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
		IN	NS	ns6.gandi.net.
		IN	NS	zinfandel.levkowetz.com.
		IN	NS	cabernet.levkowetz.com.
		IN	NS	grenache.levkowetz.com.
		IN	MX	None levkowetz.com
		IN	MX	None levkowetz.com
		IN	MX	None levkowetz.com
None		IN	A	64.170.98.42
None		IN	A	209.208.19.222
None		IN	A	194.146.105.14
None		IN	A	77.72.230.31
None		IN	A	192.36.165.30
None		IN	A	77.72.230.30
; EOF