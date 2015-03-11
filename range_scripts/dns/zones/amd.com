; Zone File for amd.com
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
		IN	NS	svl3d.amd.com.
		IN	NS	atl3d.amd.com.
		IN	MX	None amd.com
None		IN	A	23.67.61.169
None		IN	A	23.67.61.185
None		IN	A	172.226.235.218
None		IN	A	165.204.85.12
None		IN	A	139.95.253.10
None		IN	A	165.204.84.65
None		IN	CNAME	dsa-sites.amd.com.edgesuite.net.
None		IN	CNAME	dsa-www.amd.com.edgekey.net.
None		IN	TXT	"amdext.amd.com."
None		IN	TXT	"amdext2.amd.com."
None		IN	TXT	"amdext5.amd.com."
None		IN	TXT	"amdext6.amd.com."
; EOF