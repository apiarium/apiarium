; Zone File for directnic.com
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
		IN	NS	ns1.directnic.com.
		IN	NS	ns0.directnic.com.
		IN	MX	None directnic.com
None		IN	A	74.117.218.20
None		IN	A	74.117.217.20
None		IN	A	199.7.106.4
None		IN	TXT	"google-site-verification=YdcANU49MzbBXVDud8CMYgtmVDOiUnPvLGyhPEgmWNM"
None		IN	TXT	"v=spf1 include:spf.mandrillapp.com include:_spf.google.com include:spf.directnic.com include:spf-a.directnic.com ~all"
; EOF