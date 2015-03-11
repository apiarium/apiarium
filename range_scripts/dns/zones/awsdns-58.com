; Zone File for awsdns-58.com
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
		IN	NS	g-ns-59.awsdns-58.com.
		IN	NS	g-ns-634.awsdns-58.com.
		IN	NS	g-ns-1210.awsdns-58.com.
		IN	NS	g-ns-1786.awsdns-58.com.
None		IN	A	205.251.193.213
None		IN	A	205.251.192.59
None		IN	A	205.251.194.122
None		IN	A	205.251.196.186
None		IN	A	205.251.198.250
; EOF