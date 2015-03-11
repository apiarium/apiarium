; Zone File for bac.com
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
		IN	NS	ns12.bac.com.
		IN	NS	ns6.bac.com.
		IN	NS	ns7.bac.com.
		IN	NS	ns10.bac.com.
		IN	NS	ns8.bac.com.
		IN	NS	ns11.bac.com.
		IN	MX	None bac.com
		IN	MX	None bac.com
		IN	MX	None bac.com
		IN	MX	None bac.com
None		IN	A	184.85.248.67
None		IN	A	84.53.139.64
None		IN	A	171.162.5.164
None		IN	A	171.162.6.164
None		IN	A	2.22.230.64
None		IN	A	193.108.91.121
None		IN	A	171.161.206.99
None		IN	A	171.161.207.99
None		IN	A	171.161.198.99
None		IN	A	171.161.199.99
None		IN	A	171.161.202.99
None		IN	A	171.161.203.99
; EOF