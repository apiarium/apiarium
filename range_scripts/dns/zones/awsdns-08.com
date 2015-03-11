; Zone File for awsdns-08.com
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
		IN	NS	g-ns-1160.awsdns-08.com.
		IN	NS	g-ns-1736.awsdns-08.com.
		IN	NS	g-ns-584.awsdns-08.com.
		IN	NS	g-ns-9.awsdns-08.com.
None		IN	A	205.251.192.64
None		IN	A	205.251.196.136
None		IN	A	205.251.198.200
None		IN	A	205.251.194.72
None		IN	A	205.251.192.9
; EOF