; Zone File for awsdns-36.com
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
		IN	NS	g-ns-1764.awsdns-36.com.
		IN	NS	g-ns-612.awsdns-36.com.
		IN	NS	g-ns-37.awsdns-36.com.
		IN	NS	g-ns-1188.awsdns-36.com.
None		IN	A	205.251.193.38
None		IN	A	205.251.198.228
None		IN	A	205.251.194.100
None		IN	A	205.251.192.37
None		IN	A	205.251.196.164
; EOF