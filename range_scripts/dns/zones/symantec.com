; Zone File for symantec.com
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
		IN	NS	pdns6.ultradns.co.uk.
		IN	NS	pdns2.ultradns.net.
		IN	NS	pdns4.ultradns.org.
		IN	NS	pdns5.ultradns.info.
		IN	NS	pdns1.ultradns.net.
		IN	NS	udns2.ultradns.net.
		IN	NS	pdns3.ultradns.org.
		IN	NS	udns1.ultradns.net.
		IN	MX	None symantec.com
		IN	MX	None symantec.com
		IN	MX	None symantec.com
None		IN	A	143.127.10.103
None		IN	A	172.226.211.29
None		IN	A	184.28.29.29
None		IN	A	216.12.145.20
None		IN	A	206.204.52.31
None		IN	CNAME	buy.symanteccloud.com.gtm.symantec.com.
None		IN	CNAME	partnernet.symantec.com.edgekey.net.
None		IN	CNAME	www.symantec.com.akadns.net.
None		IN	TXT	"v=spf1 include:spf.symantec.com ip4:207.38.45.154 include:spf.messagelabs.com include:spf-ilg.symantec.com include:spf-mtv.symantec.com ip4:63.245.193.25 ip4:63.245.197.25 ip4:63.245.201.25 ~all"
; EOF