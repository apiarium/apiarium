; Zone File for domaincontrol.com
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
		IN	NS	ans02.domaincontrol.com.
		IN	NS	ans01.domaincontrol.com.
		IN	MX	None domaincontrol.com
		IN	MX	None domaincontrol.com
None		IN	A	208.109.255.42
None		IN	A	216.69.185.42
None		IN	A	208.109.255.50
None		IN	A	216.69.185.50
None		IN	A	127.0.0.1
None		IN	A	208.109.255.52
None		IN	A	216.69.185.52
None		IN	A	208.109.255.35
None		IN	A	216.69.185.35
None		IN	TXT	"IPROTA_D17769-XXX.TXT"
; EOF