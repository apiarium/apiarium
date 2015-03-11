; Zone File for yahoo.com
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
		IN	NS	ns5.yahoo.com.
		IN	NS	ns1.yahoo.com.
		IN	NS	ns6.yahoo.com.
		IN	NS	ns4.yahoo.com.
		IN	NS	ns2.yahoo.com.
		IN	NS	ns3.yahoo.com.
		IN	MX	None ns5.yahoo.com
		IN	MX	None ns1.yahoo.com
		IN	MX	None ns6.yahoo.com
		IN	MX	None ns4.yahoo.com
		IN	MX	None ns2.yahoo.com
		IN	MX	None ns3.yahoo.com
		IN	MX	None yahoo.com
		IN	MX	None yahoo.com
		IN	MX	None yahoo.com
None		IN	A	216.115.101.179
None		IN	A	206.190.57.61
None		IN	A	98.139.199.204
None		IN	A	206.190.57.60
None		IN	A	98.138.253.109
None		IN	A	206.190.36.45
None		IN	A	98.139.183.24
None		IN	A	119.160.247.124
None		IN	A	68.180.131.16
None		IN	A	121.101.144.139
None		IN	A	98.138.11.157
None		IN	A	68.142.255.16
None		IN	A	203.84.221.53
None		IN	A	98.139.180.149
None		IN	A	98.139.183.24
None		IN	CNAME	fd-geoycpi-uno.gycpi.b.yahoodns.net.
None		IN	CNAME	fd-fp3.wg1.b.yahoo.com.
None		IN	TXT	"v=spf1 redirect=_spf.mail.yahoo.com"
; EOF