; Zone File for halldata.com
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
		IN	NS	ns2.halldata.com.
		IN	NS	ns1.halldata.com.
		IN	MX	None halldata.com
		IN	MX	None halldata.com
None		IN	A	65.163.193.155
None		IN	A	8.6.95.126
None		IN	A	199.168.173.141
None		IN	TXT	"spf2.0/pra mx mx:barracuda3.halldata.com mx:barracuda2.halldata.com mx:barracuda2.halldata.com mx:mail.zendesk.com ~all"
None		IN	TXT	"v=spf1 mx mx:barracuda3.halldata.com mx:barracuda2.halldata.com mx:barracuda.halldata.com mx:mail.zendesk.com ~all"
; EOF