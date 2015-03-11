; Zone File for ericsson.com
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
		IN	NS	ns1.ericsson.se.
		IN	NS	e3dns.ericy.com.
		IN	NS	ns2.ericsson.se.
		IN	MX	None ericsson.com
		IN	MX	None ericsson.com
		IN	MX	None ericsson.com
		IN	MX	None ericsson.com
		IN	MX	None ericsson.com
		IN	MX	None ericsson.com
		IN	MX	None ericsson.com
None		IN	A	23.67.61.179
None		IN	A	23.67.61.194
None		IN	A	193.180.16.203
None		IN	CNAME	www.ericsson.com.edgesuite.net.
None		IN	TXT	"wQNpwSrHlkTBhDgFqTP0FwHG0mFGcVXdYe5Ftl8O6igJEcymxD64dGjUC1DvpIS+wzveEv/3nk+e7WUIWd+Oxg=="
None		IN	TXT	"v=spf1 ip4:193.180.251.0/24 ip4:194.237.142.0/24 ip4:193.180.14.0/23 ip4:198.24.6.0/23 ip4:192.176.1.0/24 ip4:213.68.11.192/26 include:_spf.google.com include:customers.clickdimensions.com ~all"
; EOF