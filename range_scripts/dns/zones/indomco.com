; Zone File for indomco.com
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
		IN	NS	indom10.indomco.com.
		IN	NS	indom20.indomco.net.
		IN	NS	indom30.indomco.fr.
		IN	NS	indom80.indomco.hk.
		IN	MX	None indomco.com
		IN	MX	None indom10.indomco.com
		IN	MX	None indom10.indomco.com
		IN	MX	None indomco.com
		IN	MX	None indom10.indomco.com
		IN	MX	None indomco.com
None		IN	A	217.174.200.97
None		IN	A	217.174.202.146
; EOF