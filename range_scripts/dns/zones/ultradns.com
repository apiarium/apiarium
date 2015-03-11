; Zone File for ultradns.com
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
		IN	NS	pdns196.ultradns.info.
		IN	NS	pdns196.ultradns.biz.
		IN	NS	pdns196.ultradns.com.
		IN	NS	pdns196.ultradns.org.
		IN	NS	pdns196.ultradns.net.
		IN	NS	pdns196.ultradns.co.uk.
		IN	MX	None ultradns.com
		IN	MX	None ultradns.com
None		IN	A	156.154.64.89
None		IN	A	156.154.42.226
None		IN	A	156.154.64.196
None		IN	TXT	"Security Issues Contact: 1-650-228-2391"
None		IN	TXT	"v=spf1 ip4:204.74.100.0/24 ip4:204.74.97.97 ip4:204.74.104.97 ip4:204.74.97.5 ip4:204.74.104.5 ip4:204.74.102.5 ip4:204.74.104.40 ip4:204.74.98.40 ip4:204.74.102.40 mx:postfix.ultradns.net mx:mailgate.ultradns.net mx:exchange.ultradns.com ~all"
None		IN	TXT	"v=spf1 ip4:204.74.100.0/24 ip4:67.106.186.126  ip4: 67.109.57.70 ip4:204.74.97.5 ip4:204.74.104.5 ip4:204.74.102.5 ip4:204.74.104.40 ip4:204.74.98.40 ip4:204.74.102.40 mx:postfix.ultradns.net mx:mailgate.ultradns.net mx:exchange.ultradns.com ~all"
; EOF