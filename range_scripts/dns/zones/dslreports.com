; Zone File for dslreports.com
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
		IN	NS	ns-636.awsdns-15.net.
		IN	NS	ns-1762.awsdns-28.co.uk.
		IN	NS	ns-1470.awsdns-55.org.
		IN	NS	ns-267.awsdns-33.com.
		IN	MX	None dslreports.com
None		IN	A	64.91.255.98
None		IN	A	64.91.255.98
None		IN	TXT	"v=spf1 mx a ptr ~all"
; EOF