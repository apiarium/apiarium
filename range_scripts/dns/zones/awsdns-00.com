; Zone File for awsdns-00.com
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
		IN	NS	g-ns-1152.awsdns-00.com.
		IN	NS	g-ns-1.awsdns-00.com.
		IN	NS	g-ns-1728.awsdns-00.com.
		IN	NS	g-ns-576.awsdns-00.com.
None		IN	A	205.251.192.3
None		IN	A	205.251.196.128
None		IN	A	205.251.192.1
None		IN	A	205.251.198.192
None		IN	A	205.251.194.64
; EOF