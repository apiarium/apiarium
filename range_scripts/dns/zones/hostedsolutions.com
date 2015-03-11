; Zone File for hostedsolutions.com
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
		IN	NS	ns1.bos.hostedsolutions.com.
		IN	NS	ns1.ral.hostedsolutions.com.
		IN	NS	ns1.lit.hostedsolutions.com.
		IN	NS	ns1.clt.hostedsolutions.com.
		IN	MX	None hostedsolutions.com
		IN	MX	None hostedsolutions.com
		IN	MX	None hostedsolutions.com
None		IN	A	216.27.81.251
None		IN	A	216.27.75.99
None		IN	A	69.40.208.133
None		IN	A	209.59.13.227
None		IN	A	69.166.152.39
None		IN	A	172.18.21.223
None		IN	A	172.18.37.223
None		IN	A	40.143.47.77
None		IN	A	40.143.47.78
None		IN	A	40.143.47.84
; EOF