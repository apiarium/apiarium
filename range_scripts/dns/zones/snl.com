; Zone File for snl.com
; Generated Wed Dec  3 13:54:57 2014
$TTL 172800
$ORIGIN snl.com.
@		IN	SOA	ns5.snl.com. hostmaster.snl.com. (
			  1417403386
			  16384
			  2048
			  1048576
			  2560
			  )
		IN	NS	ns5.snl.com.
		IN	NS	ns6.snl.com.
		IN	NS	ns7.snl.com.
		IN	MX	100 snl.com.s5a1.psmtp.com. snl.com
		IN	MX	200 snl.com.s5a2.psmtp.com. snl.com
		IN	MX	300 snl.com.s5b1.psmtp.com. snl.com
		IN	MX	400 snl.com.s5b2.psmtp.com. snl.com
ns4.snl.com.		IN	A	216.30.177.38
ns3.snl.com.		IN	A	216.197.69.38
snl.com.		IN	A	216.197.69.72
snl.com.		IN	A	216.30.177.104
ns5.snl.com.		IN	A	216.197.69.39
ns6.snl.com.		IN	A	216.30.177.39
ns7.snl.com.		IN	A	216.197.69.45
snl.com.		IN	TXT	"google-site-verification=1MADlAkdT4ohxF5L3ixnUf-80w9ACdQmSOfgsea3uh4"
snl.com.		IN	TXT	"v=spf1 include:_spf.google.com include:mktomail.com ip4:216.197.69.0/24 ip4:216.30.177.0/24 ip4:207.126.120.0/24 include:workda" "y.com ip4:24.106.58.166 ip4:65.52.232.173 ip4:157.55.209.64 ip4:62.13.150.47 a:snl.officespacesoftware.com include:vocus.com ip" "4:208.185.229.0/24 ip4:208.185.235.0/24 ~all"
;EOF