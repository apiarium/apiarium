; Zone File for dig.com
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
		IN	NS	orns01.dig.com.
		IN	NS	orns02.dig.com.
		IN	NS	sens01.dig.com.
		IN	NS	sens02.dig.com.
		IN	MX	None dig.com
		IN	MX	None dig.com
None		IN	A	68.71.223.14
None		IN	A	139.104.186.14
None		IN	A	139.104.186.13
None		IN	A	68.71.223.15
None		IN	A	199.181.132.250
None		IN	TXT	"v=spf1 mx ip4:204.128.192.17 ip4:204.128.192.36 ip4:204.128.192.43 ip4:192.195.66.26 ip4:192.195.66.28 ip4:192.195.66.36 include:woc.spf.go.com -all"
; EOF