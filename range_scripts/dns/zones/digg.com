; Zone File for digg.com
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
		IN	NS	ns-1131.awsdns-13.org.
		IN	NS	ns-1886.awsdns-43.co.uk.
		IN	NS	ns-929.awsdns-52.net.
		IN	NS	ns-147.awsdns-18.com.
		IN	MX	None digg.com
		IN	MX	None digg.com
		IN	MX	None digg.com
		IN	MX	None digg.com
		IN	MX	None digg.com
None		IN	A	50.18.125.174
None		IN	A	50.18.125.174
None		IN	TXT	"spf2.0/pra include:aspmx.sailthru.com include:aspmx.googlemail.com include:mail.zendesk.com -all"
None		IN	TXT	"v=spf1 include:aspmx.sailthru.com include:aspmx.googlemail.com include:mail.zendesk.com -all"
; EOF