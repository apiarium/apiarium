; Zone File for awsdns-59.com
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
		IN	NS	g-ns-1787.awsdns-59.com.
		IN	NS	g-ns-1211.awsdns-59.com.
		IN	NS	g-ns-635.awsdns-59.com.
		IN	NS	g-ns-60.awsdns-59.com.
None		IN	A	205.251.193.222
None		IN	A	205.251.198.251
None		IN	A	205.251.196.187
None		IN	A	205.251.194.123
None		IN	A	205.251.192.60
; EOF