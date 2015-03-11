; Zone File for imgur.com
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
		IN	NS	dns4.p03.nsone.net.
		IN	NS	dns2.p03.nsone.net.
		IN	NS	dns1.p03.nsone.net.
		IN	NS	dns3.p03.nsone.net.
		IN	MX	None imgur.com
		IN	MX	None www.imgur.com
		IN	MX	None imgur.com
		IN	MX	None www.imgur.com
		IN	MX	None imgur.com
		IN	MX	None www.imgur.com
		IN	MX	None imgur.com
		IN	MX	None www.imgur.com
		IN	MX	None imgur.com
		IN	MX	None www.imgur.com
None		IN	A	23.235.44.193
None		IN	A	23.235.40.193
None		IN	CNAME	imgur.com.
None		IN	TXT	"v=spf1 include:mailgun.org ~all"
None		IN	TXT	"v=spf1 include:mailgun.org ~all"
; EOF