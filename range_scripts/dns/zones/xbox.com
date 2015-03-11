; Zone File for xbox.com
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
		IN	NS	ns4.msft.net.
		IN	NS	ns2.msft.net.
		IN	NS	ns3.msft.net.
		IN	NS	ns1.msft.net.
		IN	MX	None xbox.com
None		IN	A	172.226.235.141
None		IN	A	134.170.29.82
None		IN	A	134.170.29.210
None		IN	CNAME	support.xbox.com.akadns.net.
None		IN	TXT	"b1939PPDAGDjXs+54riWGyuzfCM+s+PE66uPOHEQ+9z264YnfenE2CVrUxq+5UGTDqiOU8JqZ5AKRvfcUVpfXQ=="
None		IN	TXT	"v=spf1 ip4:65.55.42.0/24 ip4:65.55.76.0/24 mx:xbox.com include:_spf-ssg-a.microsoft.com include:spf.protection.outlook.com ~all"
; EOF