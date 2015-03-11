; Zone File for dell.com
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
		IN	NS	ns6.us.dell.com.
		IN	NS	ns1.us.dell.com.
		IN	NS	ns4.us.dell.com.
		IN	NS	ns2.us.dell.com.
		IN	NS	ns3.us.dell.com.
		IN	NS	ns5.us.dell.com.
		IN	MX	None dell.com
		IN	MX	None dell.com
None		IN	A	143.166.224.207
None		IN	A	192.16.31.62
None		IN	A	143.166.147.101
None		IN	A	143.166.135.105
None		IN	A	143.166.224.235
None		IN	A	143.166.82.251
None		IN	A	143.166.224.11
None		IN	A	143.166.82.252
None		IN	A	143.166.224.3
None		IN	A	143.166.83.13
None		IN	CNAME	search.ins.dell.com.
None		IN	CNAME	www1.dell-cidr.akadns.net.
None		IN	TXT	"v=spf1 ip4:143.166.85.192/26 ip4:143.166.148.192/26 ip4:211.130.110.88 ip4:143.166.82.0/24 ip4:143.166.224.0/24 ip4:202.188.162.48/26 ip4:74.52.181.211 ip4:98.158.19.7 ip4:199.30.95.252 ip4:64.88.186.40 ~all"
None		IN	TXT	"Will_Nash : Michael Dell Demo: Adding TXT Record to DNS Config for Google Verification"
None		IN	TXT	"google-site-verification=AVX0aekCtf8Nze2pPMsWnv-scckxtfYLpNmwfX_vNuU"
; EOF