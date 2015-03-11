; Zone File for awsdns-15.com
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
		IN	NS	g-ns-16.awsdns-15.com.
		IN	NS	g-ns-1743.awsdns-15.com.
		IN	NS	g-ns-1167.awsdns-15.com.
		IN	NS	g-ns-591.awsdns-15.com.
None		IN	A	205.251.192.126
None		IN	A	205.251.192.16
None		IN	A	205.251.198.207
None		IN	A	205.251.196.143
None		IN	A	205.251.194.79
; EOF