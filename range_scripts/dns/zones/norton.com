; Zone File for norton.com
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
		IN	NS	pdns3.ultradns.org.
		IN	NS	udns2.ultradns.net.
		IN	NS	udns1.ultradns.net.
		IN	NS	pdns2.ultradns.net.
		IN	NS	pdns5.ultradns.info.
		IN	NS	pdns1.ultradns.net.
		IN	NS	pdns4.ultradns.org.
		IN	MX	None norton.com
		IN	MX	None norton.com
		IN	MX	None norton.com
		IN	MX	None norton.com
		IN	MX	None norton.com
None		IN	A	184.29.252.185
None		IN	A	216.12.145.20
None		IN	A	206.204.52.31
None		IN	CNAME	san.norton.com.edgekey.net.
None		IN	TXT	"v=spf1 ip4:198.6.49.12 ip4:198.6.49.23 ip4:216.10.194.28 ip4:216.10.194.135 ip4:67.134.208.134 ip4:63.245.193.25 ip4:63.245.197.25 ip4:63.245.201.25 include:spf-ilg.norton.com include:spf-mtv.norton.com include:spf.symantec.com include:spf.messagelabs.com" " ~all"
; EOF