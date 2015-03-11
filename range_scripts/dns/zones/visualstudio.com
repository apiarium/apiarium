; Zone File for visualstudio.com
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
		IN	NS	prd4.azuredns-cloud.net.
		IN	NS	prd2.azuredns-cloud.net.
		IN	NS	prd3.azuredns-cloud.net.
		IN	NS	prd1.azuredns-cloud.net.
None		IN	A	157.56.75.140
None		IN	A	65.54.226.180
None		IN	A	157.56.75.6
None		IN	A	157.56.148.39
None		IN	CNAME	lb1.visualstudio.com.akadns.net.
; EOF