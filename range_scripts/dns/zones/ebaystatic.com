; Zone File for ebaystatic.com
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
		IN	NS	ns4.p47.dynect.net.
		IN	NS	ns3.p47.dynect.net.
		IN	NS	ns2.p47.dynect.net.
		IN	NS	sjc-dns2.ebaydns.com.
		IN	NS	ns1.p47.dynect.net.
		IN	NS	smf-dns2.ebaydns.com.
		IN	NS	sjc-dns1.ebaydns.com.
		IN	NS	smf-dns1.ebaydns.com.
		IN	MX	None ebaystatic.com
		IN	MX	None ebaystatic.com
		IN	MX	None ebaystatic.com
None		IN	A	23.67.61.179
None		IN	A	23.67.61.195
None		IN	CNAME	ir.ebaystatic.com.edgesuite.net.
; EOF