; Zone File for ebaydns.com
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
		IN	NS	sjc-dns1.ebaydns.com.
		IN	NS	smf-dns2.ebaydns.com.
		IN	NS	sjc-dns2.ebaydns.com.
		IN	NS	smf-dns1.ebaydns.com.
		IN	MX	None ebaydns.com
		IN	MX	None ebaydns.com
		IN	MX	None ebaydns.com
None		IN	A	66.135.207.138
None		IN	A	66.135.215.5
None		IN	A	66.135.207.137
None		IN	A	66.135.223.137
; EOF