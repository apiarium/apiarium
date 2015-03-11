; Zone File for hp.com
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
		IN	NS	ns4.hp.com.
		IN	NS	ns2.hp.com.
		IN	NS	ns3.hp.com.
		IN	NS	ns5.hp.com.
		IN	NS	ns1.hp.com.
		IN	NS	ns6.hp.com.
		IN	MX	None hp.com
None		IN	A	15.240.32.163
None		IN	A	15.240.60.88
None		IN	A	8.18.233.75
None		IN	A	208.74.204.203
None		IN	A	15.192.8.59
None		IN	A	15.192.89.48
None		IN	A	15.240.33.118
None		IN	A	23.67.61.176
None		IN	A	23.67.61.192
None		IN	A	172.226.224.145
None		IN	A	15.201.49.153
None		IN	A	15.217.49.154
None		IN	A	23.67.61.195
None		IN	A	23.67.61.187
None		IN	A	15.211.192.12
None		IN	A	15.195.208.12
None		IN	A	15.219.145.12
None		IN	A	15.203.224.14
None		IN	A	15.195.192.37
None		IN	A	15.219.160.12
None		IN	A	15.193.176.227
None		IN	A	15.217.232.245
None		IN	A	15.216.241.18
None		IN	A	15.240.60.238
None		IN	A	15.201.225.10
None		IN	A	15.192.124.145
None		IN	CNAME	z2z-hpcom-static2-prd-05.external.hp.com.
None		IN	CNAME	literatureserver.houston.hp.com.
None		IN	CNAME	hp.aqueduct.com.
None		IN	CNAME	psg.lithium.com.
None		IN	CNAME	hpwpux-pro.atlanta.hp.com.
None		IN	CNAME	s2s-hpcom-apps-prd-07-08.atlanta.hp.com.
None		IN	CNAME	z2z-hpcom-static-prd-00.external.hp.com.
None		IN	CNAME	m.hp.com.edgesuite.net.
None		IN	CNAME	shopping1.hp.com.edgekey.net.
None		IN	CNAME	www.hpgtm.nsatc.net.
None		IN	CNAME	www8.hp.com.edgesuite.net.
None		IN	TXT	"Microsoft Federation, Kathy Pollert, 03-22-2012"
None		IN	TXT	"MS=ms40557005"
None		IN	TXT	"google-site-verification:2kiyv1SjebKUcEmaJ4QtapQe2EcbqPcYmhiJ-XJMZsY"
; EOF