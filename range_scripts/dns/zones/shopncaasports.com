; Zone File for shopncaasports.com
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
		IN	NS	ns5.timewarner.net.
		IN	NS	ns1.timewarner.net.
		IN	NS	ns3.timewarner.net.
		IN	MX	None www.shopncaasports.com
		IN	MX	None shopncaasports.com
		IN	MX	None www.shopncaasports.com
		IN	MX	None shopncaasports.com
		IN	MX	None www.shopncaasports.com
		IN	MX	None shopncaasports.com
		IN	MX	None www.shopncaasports.com
		IN	MX	None shopncaasports.com
		IN	MX	None www.shopncaasports.com
		IN	MX	None shopncaasports.com
None		IN	A	66.129.84.44
None		IN	A	66.129.84.44
None		IN	CNAME	shopncaasports.com.
None		IN	TXT	"ms=ms11405805"
None		IN	TXT	"ms=ms11405805"
; EOF