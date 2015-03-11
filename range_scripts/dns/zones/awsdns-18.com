; Zone File for awsdns-18.com
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
		IN	NS	g-ns-594.awsdns-18.com.
		IN	NS	g-ns-19.awsdns-18.com.
		IN	NS	g-ns-1746.awsdns-18.com.
		IN	NS	g-ns-1170.awsdns-18.com.
None		IN	A	205.251.192.147
None		IN	A	205.251.194.82
None		IN	A	205.251.192.19
None		IN	A	205.251.198.210
None		IN	A	205.251.196.146
; EOF