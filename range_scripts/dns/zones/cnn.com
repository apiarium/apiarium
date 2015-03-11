; Zone File for cnn.com
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
		IN	NS	ns3.timewarner.net.
		IN	NS	ns1.p42.dynect.net.
		IN	NS	ns2.p42.dynect.net.
		IN	NS	ns1.timewarner.net.
		IN	MX	None cnn.com
		IN	MX	None cnn.com
		IN	MX	None cnn.com
		IN	MX	None cnn.com
		IN	MX	None cnn.com
None		IN	A	66.155.11.244
None		IN	A	66.155.9.244
None		IN	A	76.74.255.123
None		IN	A	76.74.255.117
None		IN	A	192.0.82.250
None		IN	A	192.0.83.250
None		IN	A	76.74.255.123
None		IN	A	76.74.255.117
None		IN	A	192.0.82.250
None		IN	A	192.0.83.250
None		IN	A	66.155.11.244
None		IN	A	66.155.9.244
None		IN	A	76.74.255.117
None		IN	A	192.0.82.250
None		IN	A	192.0.83.250
None		IN	A	66.155.11.244
None		IN	A	66.155.9.244
None		IN	A	76.74.255.123
None		IN	A	192.0.82.250
None		IN	A	192.0.83.250
None		IN	A	66.155.11.244
None		IN	A	66.155.9.244
None		IN	A	76.74.255.123
None		IN	A	76.74.255.117
None		IN	A	66.155.11.244
None		IN	A	66.155.9.244
None		IN	A	76.74.255.123
None		IN	A	76.74.255.117
None		IN	A	192.0.82.250
None		IN	A	192.0.83.250
None		IN	A	66.155.9.244
None		IN	A	76.74.255.123
None		IN	A	76.74.255.117
None		IN	A	192.0.82.250
None		IN	A	192.0.83.250
None		IN	A	66.155.11.244
None		IN	A	192.0.78.13
None		IN	A	192.0.78.12
None		IN	A	192.0.78.13
None		IN	A	192.0.78.12
None		IN	A	76.74.255.123
None		IN	A	76.74.255.117
None		IN	A	192.0.82.250
None		IN	A	192.0.83.250
None		IN	A	66.155.11.244
None		IN	A	66.155.9.244
None		IN	A	76.74.255.117
None		IN	A	192.0.82.250
None		IN	A	192.0.83.250
None		IN	A	66.155.11.244
None		IN	A	66.155.9.244
None		IN	A	76.74.255.123
None		IN	A	192.0.83.250
None		IN	A	66.155.11.244
None		IN	A	66.155.9.244
None		IN	A	76.74.255.123
None		IN	A	76.74.255.117
None		IN	A	192.0.82.250
None		IN	A	66.155.11.244
None		IN	A	66.155.9.244
None		IN	A	76.74.255.123
None		IN	A	76.74.255.117
None		IN	A	192.0.82.250
None		IN	A	192.0.83.250
None		IN	A	157.166.248.11
None		IN	A	157.166.249.10
None		IN	A	157.166.249.11
None		IN	A	157.166.248.10
None		IN	A	157.166.226.26
None		IN	A	157.166.226.25
None		IN	CNAME	cnnac360.wordpress.com.
None		IN	CNAME	cnnespanol.wordpress.com.
None		IN	CNAME	cnnthemoment.wordpress.com.
None		IN	CNAME	cnnpresents.wordpress.com.
None		IN	CNAME	cnnearlystart.wordpress.com.
None		IN	CNAME	cnngps.wordpress.com.
None		IN	CNAME	cnninsideman.wordpress.com.
None		IN	CNAME	cnnnewday.wordpress.com.
None		IN	CNAME	cnnpiersmorgan.wordpress.com.
None		IN	CNAME	cnnreliablesources.wordpress.com.
None		IN	CNAME	cnnsituationroom.wordpress.com.
None		IN	CNAME	cnnsotu.wordpress.com.
None		IN	CNAME	www.cnn.com.vgtf.net.
None		IN	TXT	"186844776-4422028"
None		IN	TXT	"353665828-4422052"
None		IN	TXT	"228426766-4422034"
None		IN	TXT	"299762315-4422055"
None		IN	TXT	"826218936-4422046"
None		IN	TXT	"598362927-4422061"
None		IN	TXT	"267933795-4422004"
None		IN	TXT	"782989862-4417942"
None		IN	TXT	"126953328-4422040"
None		IN	TXT	"294913881-4422049"
None		IN	TXT	"667921863-4422007"
None		IN	TXT	"764482256-4422025"
None		IN	TXT	"755973593-4422016"
None		IN	TXT	"MS=ms66433104"
None		IN	TXT	"714321471-4421998"
None		IN	TXT	"287893558-4422013"
None		IN	TXT	"321159687-4422031"
None		IN	TXT	"754516718-4422064"
None		IN	TXT	"349997471-4422043"
None		IN	TXT	"528183251-4422019"
None		IN	TXT	"882269757-4422010"
None		IN	TXT	"ms=ms97284866"
None		IN	TXT	"688162515-4422037"
None		IN	TXT	"133461244-4422058"
None		IN	TXT	"553992719-4400647"
None		IN	TXT	"178953534-4422001"
None		IN	TXT	"691244352-4422022"
; EOF