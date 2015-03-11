; Zone File for liveplan.com
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
		IN	NS	ns-321.awsdns-40.com.
		IN	NS	ns-2017.awsdns-60.co.uk.
		IN	NS	ns-1174.awsdns-18.org.
		IN	NS	ns-554.awsdns-05.net.
		IN	MX	None liveplan.com
		IN	MX	None liveplan.com
		IN	MX	None liveplan.com
None		IN	A	54.236.158.111
None		IN	A	54.165.164.78
None		IN	A	54.236.158.111
None		IN	A	54.165.164.78
None		IN	CNAME	lapinvpc-1982570052.us-east-1.elb.amazonaws.com.
None		IN	TXT	"google-site-verification=_rHddUD1uvTdJtck3p3oLn5VsCA2XBJKZBP0WXM85kU"
None		IN	TXT	"v=spf1 include:spf.mandrillapp.com include:paloaltospf.smtp.com include:emailcenterpro.com include:_spf.google.com include:spf.mailengine1.com ip4:72.19.225.50 ip4:67.216.226.149 ~all"
; EOF