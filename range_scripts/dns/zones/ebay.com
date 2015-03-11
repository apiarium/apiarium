; Zone File for ebay.com
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
		IN	NS	sjc-dns2.ebaydns.com.
		IN	NS	ns2.p47.dynect.net.
		IN	NS	ns1.p47.dynect.net.
		IN	NS	ns3.p47.dynect.net.
		IN	NS	smf-dns1.ebaydns.com.
		IN	NS	ns4.p47.dynect.net.
		IN	NS	smf-dns2.ebaydns.com.
		IN	NS	sjc-dns1.ebaydns.com.
		IN	MX	None ebay.com
		IN	MX	None ebay.com
		IN	MX	None ebay.com
None		IN	A	66.211.160.88
None		IN	A	66.211.160.196
None		IN	A	66.135.216.190
None		IN	A	66.211.185.50
None		IN	A	66.135.210.181
None		IN	A	66.211.181.161
None		IN	A	66.211.181.181
None		IN	A	66.135.210.61
None		IN	A	66.211.160.87
None		IN	A	66.135.216.190
None		IN	A	66.211.160.86
None		IN	CNAME	pages.g.ebay.com.
None		IN	CNAME	parts.motors.g.ebay.com.
None		IN	CNAME	www-us.g.ebay.com.
None		IN	TXT	"WMDPDNzMRPtGaWVpOmyS2XBHs1Fdel2FJWpPNk6OZYKqF8dEPHQcD6quj8ZnWFVgKZ13L+HisNSpWeLTTu78UQ=="
None		IN	TXT	"spf2.0/pra mx include:s._sid.ebay.com include:c._sid.ebay.com include:p._sid.ebay.com include:p2._spf.ebay.com ~all"
None		IN	TXT	"v=spf1 mx include:s._spf.ebay.com include:c._spf.ebay.com include:p._spf.ebay.com include:p2._spf.ebay.com include:sendgrid.net include:pp._spf.paypal.com ~all"
None		IN	TXT	"MS=ms95736179"
; EOF