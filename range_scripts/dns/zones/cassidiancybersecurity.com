; Zone File for cassidiancybersecurity.com
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
		IN	NS	indom30.indomco.fr.
		IN	NS	indom80.indomco.hk.
		IN	NS	indom130.indomco.org.
		IN	NS	indom20.indomco.net.
		IN	NS	indom10.indomco.com.
		IN	MX	None cassidiancybersecurity.com
		IN	MX	None cassidiancybersecurity.com
None		IN	A	85.182.225.55
None		IN	A	185.26.230.137
None		IN	CNAME	cassidian-cybersecurity-live.lq.mcon.net.
; EOF