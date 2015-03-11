; Zone File for name-services.com
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
		IN	NS	dns4.name-services.com.
		IN	NS	dns5.name-services.com.
		IN	NS	dns1.name-services.com.
		IN	NS	dns3.name-services.com.
		IN	NS	dns2.name-services.com.
		IN	MX	None name-services.com
		IN	MX	None name-services.com
		IN	MX	None name-services.com
None		IN	A	98.124.193.1
None		IN	A	98.124.197.1
None		IN	A	98.124.192.1
None		IN	A	98.124.196.1
None		IN	A	98.124.194.1
None		IN	A	64.74.223.37
None		IN	TXT	"v=spf1 a ip4:69.64.144.0/20 ip4:98.124.192.0/18 ip4:216.163.188.60 ip4:216.163.176.40 ip4:38.113.116.216 ~all"
; EOF