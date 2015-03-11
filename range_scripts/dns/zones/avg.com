; Zone File for avg.com
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
		IN	NS	a20-66.akam.net.
		IN	NS	a11-66.akam.net.
		IN	NS	a26-67.akam.net.
		IN	NS	a1-182.akam.net.
		IN	NS	a13-65.akam.net.
		IN	NS	a6-67.akam.net.
		IN	MX	None avg.com
		IN	MX	None avg.com
		IN	MX	None avg.com
		IN	MX	None avg.com
		IN	MX	None avg.com
None		IN	A	23.67.61.176
None		IN	A	23.67.61.186
None		IN	A	172.226.231.117
None		IN	A	93.184.217.9
None		IN	A	93.184.211.28
None		IN	CNAME	aa-download.avg.com.edgesuite.net.
None		IN	CNAME	www.avg.com.edgekey.net.
None		IN	TXT	"QjlX4bC3cPOfFTU7nqgt5pUmaMYFJGAaywwWlZ4ap1mE2YCE0kgkFc6+hgQDk5oIjNzmOAmYLAyl03fRw0mfzQ=="
None		IN	TXT	"v=spf1 redirect=spf.avg.com"
None		IN	TXT	"MS=ms58106600"
; EOF