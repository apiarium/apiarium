; Zone File for zoneedit.com
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
		IN	NS	ns-824.awsdns-39.net.
		IN	NS	ns-1030.awsdns-00.org.
		IN	NS	ns-243.awsdns-30.com.
		IN	NS	ns-1943.awsdns-50.co.uk.
		IN	MX	None zoneedit.com
None		IN	A	205.164.42.98
None		IN	A	162.220.33.236
None		IN	A	162.220.35.30
None		IN	A	205.164.42.99
None		IN	A	64.68.198.1
None		IN	TXT	"v=spf1 ip4:64.68.198.0/24 ~all"
; EOF