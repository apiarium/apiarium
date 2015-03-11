; Zone File for bankofamerica.com
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
		IN	NS	ns11.bac.com.
		IN	NS	ns8.bac.com.
		IN	NS	ns6.bac.com.
		IN	NS	ns7.bac.com.
		IN	NS	ns10.bac.com.
		IN	NS	ns12.bac.com.
		IN	MX	None bankofamerica.com
		IN	MX	None bankofamerica.com
		IN	MX	None bankofamerica.com
		IN	MX	None bankofamerica.com
None		IN	A	171.161.202.100
None		IN	A	171.161.148.150
None		IN	A	171.159.228.150
None		IN	CNAME	wwwui.ecglb.bac.com.
None		IN	TXT	"v=spf1 include:_txspf.bankofamerica.com include:_vaspf.bankofamerica.com include:_newspf.bankofamerica.com ~all"
None		IN	TXT	"XP24tQeCoyIoYKFUDBai/TAmSrkfqDi8E276kwIOINKuXcgwMZwhckPM+6x5egH7+IV5OFBRNkdgRIHmbQ4Usw=="
; EOF