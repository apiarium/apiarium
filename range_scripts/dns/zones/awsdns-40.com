; Zone File for awsdns-40.com
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
		IN	NS	g-ns-1192.awsdns-40.com.
		IN	NS	g-ns-616.awsdns-40.com.
		IN	NS	g-ns-41.awsdns-40.com.
		IN	NS	g-ns-1768.awsdns-40.com.
None		IN	A	205.251.193.65
None		IN	A	205.251.196.168
None		IN	A	205.251.194.104
None		IN	A	205.251.192.41
None		IN	A	205.251.198.232
; EOF