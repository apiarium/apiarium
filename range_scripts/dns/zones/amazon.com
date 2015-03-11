; Zone File for amazon.com
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
		IN	NS	ns-945.amazon.com.
		IN	NS	ns-921.amazon.com.
		IN	NS	ns-922.amazon.com.
		IN	NS	pdns6.ultradns.co.uk.
		IN	NS	ns3.p31.dynect.net.
		IN	NS	ns2.p31.dynect.net.
		IN	NS	pdns1.ultradns.net.
		IN	NS	ns1.p31.dynect.net.
		IN	NS	ns4.p31.dynect.net.
		IN	MX	None amazon.com
None		IN	A	176.32.100.36
None		IN	A	72.21.215.245
None		IN	A	176.32.99.11
None		IN	A	54.164.180.110
None		IN	A	54.208.64.115
None		IN	A	54.210.127.199
None		IN	A	54.165.157.190
None		IN	A	54.210.138.243
None		IN	A	54.210.57.129
None		IN	A	176.32.98.166
None		IN	A	176.32.98.166
None		IN	A	205.251.242.54
None		IN	A	72.21.215.232
None		IN	A	204.246.162.5
None		IN	A	72.21.192.215
None		IN	A	72.21.192.211
None		IN	A	204.246.160.7
None		IN	CNAME	webstorehosting.amazon.com.
None		IN	TXT	"spf2.0/pra include:spf1.amazon.com include:spf2.amazon.com include:amazonses.com -all"
None		IN	TXT	"v=spf1 include:spf1.amazon.com include:spf2.amazon.com include:amazonses.com -all"
; EOF