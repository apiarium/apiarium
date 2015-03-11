; Zone File for awsdns-62.com
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
		IN	NS	g-ns-638.awsdns-62.com.
		IN	NS	g-ns-63.awsdns-62.com.
		IN	NS	g-ns-1214.awsdns-62.com.
		IN	NS	g-ns-1790.awsdns-62.com.
None		IN	A	205.251.193.241
None		IN	A	205.251.194.126
None		IN	A	205.251.192.63
None		IN	A	205.251.196.190
None		IN	A	205.251.198.254
; EOF