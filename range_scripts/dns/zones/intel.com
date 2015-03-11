; Zone File for intel.com
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
		IN	NS	ns1.intel.com.
		IN	NS	ns4.intel.com.
		IN	MX	None intel.com
		IN	MX	None intel.com
		IN	MX	None intel.com
		IN	MX	None intel.com
		IN	MX	None intel.com
None		IN	A	23.67.61.187
None		IN	A	23.67.61.192
None		IN	A	198.175.116.54
None		IN	A	192.55.52.33
None		IN	A	192.102.198.240
None		IN	CNAME	www.intel.com.edgesuite.net.
None		IN	TXT	"v=spf1 mx:intel.com mx:google.com include:_spf.google.com ~all"
None		IN	TXT	"adobe-idp-site-verification=12d5bea8-aab4-4b2e-9c77-8f69ad4734f0"
None		IN	TXT	"ks18gJkJ7TsKXt8U7ziMUXThUssD0Yr1DFcMZq7G4a4DI9Y5hemqf0aNi8XPuActaL4b5RL1McubYLCPHmSzog=="
; EOF