; Zone File for registrar-servers.com
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
		IN	NS	dns3.name-services.com.
		IN	NS	dns2.name-services.com.
		IN	NS	dns1.name-services.com.
		IN	NS	dns5.name-services.com.
		IN	NS	dns4.name-services.com.
		IN	MX	None registrar-servers.com
		IN	MX	None registrar-servers.com
None		IN	A	173.245.58.45
None		IN	A	69.197.21.29
None		IN	A	69.197.21.28
None		IN	A	208.64.122.242
None		IN	A	208.64.122.244
None		IN	A	69.197.21.29
None		IN	A	72.20.53.50
None		IN	A	69.197.21.28
None		IN	A	208.64.122.244
None		IN	A	208.64.122.242
None		IN	A	62.210.149.102
None		IN	A	72.20.53.50
None		IN	A	173.245.59.16
None		IN	A	208.64.122.242
None		IN	A	173.245.58.17
None		IN	A	208.64.122.244
None		IN	A	173.245.58.17
None		IN	A	173.245.59.40
None		IN	A	173.245.58.45
None		IN	A	173.245.59.16
None		IN	A	98.124.199.1
; EOF