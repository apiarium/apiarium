; Zone File for myspace.com
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
		IN	NS	ns1-128.akam.net.
		IN	NS	ns5-67.akam.net.
		IN	NS	ns7-67.akam.net.
		IN	NS	ns4-66.akam.net.
		IN	MX	None myspace.com
		IN	MX	None myspace.com
None		IN	A	216.178.46.224
None		IN	A	216.178.47.11
None		IN	CNAME	www.myspace.com.akadns.net.
None		IN	TXT	"google-site-verification=q0iWqpcfOBclAJaCeWh83v62QQ4uCgbWObQ08p37qgU"
None		IN	TXT	"v=spf1 mx ip4:63.208.226.34 ip4:204.16.32.0/22 ip4:67.134.143.0/24 ip4:216.205.243.0/24  ip4:216.32.181.16 include:spf.frontbridge.com include:bigfish.com include:vindicogroup.com -all"
; EOF