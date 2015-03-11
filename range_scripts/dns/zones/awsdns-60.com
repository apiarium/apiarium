; Zone File for awsdns-60.com
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
		IN	NS	g-ns-636.awsdns-60.com.
		IN	NS	g-ns-61.awsdns-60.com.
		IN	NS	g-ns-1212.awsdns-60.com.
		IN	NS	g-ns-1788.awsdns-60.com.
None		IN	A	205.251.193.226
None		IN	A	205.251.194.124
None		IN	A	205.251.192.61
None		IN	A	205.251.196.188
None		IN	A	205.251.198.252
; EOF