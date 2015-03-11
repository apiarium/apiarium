; Zone File for youtube.com
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
		IN	NS	ns4.google.com.
		IN	NS	ns3.google.com.
		IN	NS	ns1.google.com.
		IN	NS	ns2.google.com.
		IN	MX	None youtube.com
		IN	MX	None youtube.com
		IN	MX	None youtube.com
		IN	MX	None youtube.com
		IN	MX	None youtube.com
None		IN	A	64.233.185.93
None		IN	A	64.233.185.91
None		IN	A	64.233.185.190
None		IN	A	64.233.185.136
None		IN	A	64.233.185.190
None		IN	A	64.233.185.136
None		IN	A	64.233.185.93
None		IN	A	64.233.185.91
None		IN	CNAME	youtube-ui.l.google.com.
None		IN	TXT	"v=spf1 include:google.com mx -all"
; EOF