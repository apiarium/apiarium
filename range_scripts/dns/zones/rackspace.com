; Zone File for rackspace.com
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
		IN	NS	ns2.rackspace.com.
		IN	NS	ns.rackspace.com.
		IN	MX	None rackspace.com
		IN	MX	None rackspace.com
		IN	MX	None rackspace.com
		IN	MX	None rackspace.com
None		IN	A	69.20.95.4
None		IN	A	65.61.188.4
None		IN	A	173.203.44.122
None		IN	TXT	"v=spf1 include:spf1.rackspace.com include:spf2.rackspace.com include:spf3.rackspace.com include:spf4.rackspace.com include:spf5.rackspace.com include:spf6.rackspace.com include:spf7.rackspace.com include:spf8.rackspace.com include:spf9.rackspace.com -all"
; EOF