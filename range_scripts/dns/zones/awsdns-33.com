; Zone File for awsdns-33.com
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
		IN	NS	g-ns-1185.awsdns-33.com.
		IN	NS	g-ns-34.awsdns-33.com.
		IN	NS	g-ns-1761.awsdns-33.com.
		IN	NS	g-ns-609.awsdns-33.com.
None		IN	A	205.251.193.11
None		IN	A	205.251.196.161
None		IN	A	205.251.192.34
None		IN	A	205.251.198.225
None		IN	A	205.251.194.97
; EOF