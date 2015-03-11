; Zone File for airforce.com
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
		IN	NS	ns2.rackspace.com.
		IN	NS	ns.rackspace.com.
		IN	MX	None airforce.com
		IN	MX	None airforce.com
None		IN	A	98.129.108.62
None		IN	A	98.129.108.62
None		IN	TXT	"spf2.0/pra mx ipv4:98.129.108.0/24 ip4:66.179.26.98/28 ip4:216.150.48.0/24 ip4:216.150.49.0/24 ip4:216.150.56.0/24 ip4:216.150.57.0/24 ip4:216.150.58.0/24 ip4:199.187.224/22 ip4:72.249.101.225/32 a:mail.tribalddb.net -all"
None		IN	TXT	"v=spf1 a mx ptr ip4:162.209.85.64 ip4:75.126.83.211 ip4:173.45.230.225 ip4:184.106.175.249 ~all"
; EOF