; Zone File for awsdns-16.com
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
		IN	NS	g-ns-1744.awsdns-16.com.
		IN	NS	g-ns-17.awsdns-16.com.
		IN	NS	g-ns-1168.awsdns-16.com.
		IN	NS	g-ns-592.awsdns-16.com.
None		IN	A	205.251.192.135
None		IN	A	205.251.198.208
None		IN	A	205.251.192.17
None		IN	A	205.251.196.144
None		IN	A	205.251.194.80
; EOF