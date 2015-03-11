; Zone File for awsdns-32.com
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
		IN	NS	g-ns-608.awsdns-32.com.
		IN	NS	g-ns-1184.awsdns-32.com.
		IN	NS	g-ns-33.awsdns-32.com.
		IN	NS	g-ns-1760.awsdns-32.com.
None		IN	A	205.251.193.5
None		IN	A	205.251.194.96
None		IN	A	205.251.196.160
None		IN	A	205.251.192.33
None		IN	A	205.251.198.224
; EOF