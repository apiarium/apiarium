; Zone File for apple.com
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
		IN	NS	adns1.apple.com.
		IN	NS	nserver6.apple.com.
		IN	NS	nserver2.apple.com.
		IN	NS	nserver3.apple.com.
		IN	NS	nserver5.apple.com.
		IN	NS	nserver.apple.com.
		IN	NS	adns2.apple.com.
		IN	NS	nserver4.apple.com.
		IN	MX	None consultants.apple.com
		IN	MX	None apple.com
		IN	MX	None apple.com
		IN	MX	None apple.com
		IN	MX	None apple.com
		IN	MX	None apple.com
		IN	MX	None consultants.apple.com
		IN	MX	None apple.com
		IN	MX	None consultants.apple.com
		IN	MX	None apple.com
		IN	MX	None apple.com
		IN	MX	None apple.com
		IN	MX	None apple.com
		IN	MX	None apple.com
None		IN	A	17.254.20.131
None		IN	A	206.200.251.19
None		IN	A	184.29.253.125
None		IN	A	96.17.43.171
None		IN	A	23.40.18.146
None		IN	A	23.40.25.144
None		IN	A	17.151.20.254
None		IN	A	23.207.61.131
None		IN	A	17.142.160.59
None		IN	A	17.178.96.59
None		IN	A	17.172.224.47
None		IN	A	17.151.0.151
None		IN	A	17.171.63.40
None		IN	A	17.254.0.59
None		IN	A	17.112.144.50
None		IN	A	17.171.63.30
None		IN	A	17.254.0.50
None		IN	A	17.151.0.152
None		IN	A	17.112.144.59
None		IN	CNAME	aapl.client.shareholder.com.
None		IN	CNAME	itunes-cdn.itunes-apple.com.akadns.net.
None		IN	CNAME	store.apple.com.edgekey.net.
None		IN	CNAME	prod-support.apple-support.akadns.net.
None		IN	CNAME	trailers.apple.com.edgekey.net.
None		IN	CNAME	www.isg-apple.com.akadns.net.
None		IN	TXT	"v=spf1 ip4:17.0.0.0/8 ~all MS=ms68045945"
; EOF