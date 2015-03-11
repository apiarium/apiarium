; Zone File for urbandictionary.com
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
		IN	NS	ns-785.awsdns-34.net.
		IN	NS	ns-3.awsdns-00.com.
		IN	NS	ns-1505.awsdns-60.org.
		IN	NS	ns-1783.awsdns-30.co.uk.
		IN	MX	None urbandictionary.com
		IN	MX	None urbandictionary.com
		IN	MX	None urbandictionary.com
None		IN	A	23.235.46.207
None		IN	A	54.231.34.68
None		IN	CNAME	d.global-ssl.fastly.net.
None		IN	TXT	"google-site-verification=f6VDe2QiYhCNSGO0730O73qWwoh6fFmr7csG4PxbMOA"
None		IN	TXT	"v=spf1 include:_spf.google.com include:servers.mcsv.net include:helpscoutemail.com include:pobox.com ~all"
; EOF