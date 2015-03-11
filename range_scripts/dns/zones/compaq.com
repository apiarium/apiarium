; Zone File for compaq.com
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
		IN	NS	ns3.hp.com.
		IN	NS	ns6.hp.com.
		IN	NS	ns1.hp.com.
		IN	NS	ns4.hp.com.
		IN	NS	ns5.hp.com.
		IN	NS	ns2.hp.com.
		IN	MX	None compaq.com
None		IN	A	15.193.112.23
None		IN	A	15.201.49.21
None		IN	A	15.217.49.140
None		IN	TXT	"MS=ms88935780"
; EOF