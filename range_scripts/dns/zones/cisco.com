; Zone File for cisco.com
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
		IN	NS	ns2.cisco.com.
		IN	NS	ns1.cisco.com.
		IN	NS	ns3.cisco.com.
		IN	MX	None cisco.com
		IN	MX	None cisco.com
		IN	MX	None cisco.com
None		IN	A	172.226.235.182
None		IN	A	172.226.224.170
None		IN	A	72.163.4.161
None		IN	A	64.102.255.44
None		IN	A	72.163.5.201
None		IN	A	173.37.146.41
None		IN	CNAME	software.cisco.com.akadns.net.
None		IN	CNAME	www.cisco.com.akadns.net.
None		IN	TXT	"926723159-3188410"
None		IN	TXT	"v=spf1 ip4:173.37.147.224/27 ip4:173.37.142.64/26 ip4:173.38.212.128/27 ip4:173.38.203.0/24 ip4:64.100.0.0/14 ip4:72.163.7.160/27 ip4:72.163.197.0/24 ip4:144.254.0.0/16 ip4:66.187.208.0/20 ip4:173.37.86.0/24" " ip4:64.104.206.0/24 ip4:64.104.15.96/27 ip4:64.102.19.192/26 ip4:144.254.15.96/27 ip4:173.36.137.128/26 ip4:173.36.130.0/24 mx:res.cisco.com mx:sco.cisco.com ~all"
; EOF