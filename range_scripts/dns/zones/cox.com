; Zone File for cox.com
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
		IN	NS	ns.east.cox.net.
		IN	NS	ns.cox.net.
		IN	NS	ns.west.cox.net.
		IN	MX	None cox.com
None		IN	A	68.99.123.175
None		IN	A	68.99.123.161
None		IN	TXT	"v=msv1 t=1A155616-9012-4BF3-AEA1-31E76F79E812"
None		IN	TXT	"google-site-verification=yd_9m1USTBo5RNlsPA2JXBqdw5QsbT5thDhNryh5Zns"
None		IN	TXT	"eLG9iJc89erR6iUFZcGiTAbqj9h5OvSIrY0mdmHEvofigEd0GzywK6vy7f3lL8yUtuhD2b8kb7puoRozDy8ybA=="
; EOF