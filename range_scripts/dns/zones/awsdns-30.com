; Zone File for awsdns-30.com
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
		IN	NS	g-ns-31.awsdns-30.com.
		IN	NS	g-ns-1758.awsdns-30.com.
		IN	NS	g-ns-1182.awsdns-30.com.
		IN	NS	g-ns-606.awsdns-30.com.
None		IN	A	205.251.192.243
None		IN	A	205.251.192.31
None		IN	A	205.251.198.222
None		IN	A	205.251.196.158
None		IN	A	205.251.194.94
; EOF