; Zone File for shopmyexchange.com
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
		IN	NS	elrond.aafes.com.
		IN	NS	legolas.aafes.com.
		IN	NS	aragorn.aafes.com.
		IN	MX	None shopmyexchange.com
None		IN	A	23.34.24.84
None		IN	A	67.18.10.219
None		IN	CNAME	www.shopmyexchange.com.edgekey.net.
None		IN	TXT	"v=spf1 include:spf.protection.outlook.com -all"
None		IN	TXT	"MS=ms24623146"
; EOF