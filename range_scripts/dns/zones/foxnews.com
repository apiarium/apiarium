; Zone File for foxnews.com
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
		IN	NS	ns-478.awsdns-59.com.
		IN	NS	ns-746.awsdns-29.net.
		IN	NS	ns-1814.awsdns-34.co.uk.
		IN	NS	ns-1072.awsdns-06.org.
		IN	NS	ns1-253.akam.net.
		IN	NS	usc2.akam.net.
		IN	NS	usw3.akam.net.
		IN	NS	usc4.akam.net.
		IN	NS	dns.tpa.foxnews.com.
		IN	NS	asia3.akam.net.
		IN	NS	ns1-157.akam.net.
		IN	NS	usw1.akam.net.
		IN	MX	None ureport.foxnews.com
		IN	MX	None ureport.foxnews.com
		IN	MX	None ureport.foxnews.com
		IN	MX	None foxnews.com
		IN	MX	None ureport.foxnews.com
		IN	MX	None ureport.foxnews.com
None		IN	A	23.67.61.202
None		IN	A	23.67.61.203
None		IN	A	69.90.218.153
None		IN	A	23.67.61.145
None		IN	A	23.67.61.179
None		IN	A	2.22.55.152
None		IN	A	2.22.55.200
None		IN	A	66.230.193.6
None		IN	CNAME	radio.foxnews.com.edgesuite.net.
None		IN	CNAME	fox.fm01.net.
None		IN	CNAME	www.foxnews.com.edgesuite.net.
None		IN	TXT	"v=spf1 mx include:servers.mcsv.net include:srs.bis.na.blackberry.com include:_spf.google.com include:netblocks.fm01.net ~all"
None		IN	TXT	"qRWnq9UOByGW6DnvW8qZ4scp8GbkRYG4bsmSOyP+dzlIB+XXQtkNbpBK3qVrJ8E7YT83Bk33z5CPO1L2KlH/mA=="
None		IN	TXT	"v=spf1 ip4:66.230.193.2 include:amazonses.com include:spf.protection.outlook.com -all"
None		IN	TXT	"MS=ms40284671"
None		IN	TXT	"265947818-2009536"
; EOF