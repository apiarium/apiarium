; Zone File for cvent.com
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
		IN	NS	ns2.cvent.com.
		IN	NS	ns1.netdatacenters.com.
		IN	NS	ns1.cvent.com.
		IN	NS	ns2.netdatacenters.com.
		IN	MX	None cvent.com
		IN	MX	None cvent.com
None		IN	A	65.97.54.17
None		IN	A	65.97.54.17
None		IN	A	198.207.146.202
None		IN	A	204.239.0.1
None		IN	TXT	"v=spf1 ip4:198.207.146.196 ip4:65.97.54.246 include:cvent-planner.com ?all"
None		IN	TXT	"spf2.0/pra ip4:198.207.146.196 ip4:65.97.54.246 include:cvent-planner.com include:salesforce.com ?all"
; EOF