; Zone File for sprint.com
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
		IN	NS	ns2-auth.sprintlink.net.
		IN	NS	ns3-auth.sprintlink.net.
		IN	NS	ns1-auth.sprintlink.net.
		IN	NS	reston-ns1.telemail.net.
		IN	NS	reston-ns2.telemail.net.
		IN	NS	reston-ns3.telemail.net.
		IN	MX	None sprint.com
None		IN	A	209.208.144.204
None		IN	A	209.208.144.205
None		IN	A	209.11.136.180
None		IN	A	216.30.177.73
None		IN	A	54.244.54.210
None		IN	A	208.115.47.127
None		IN	A	144.230.172.24
None		IN	A	206.159.101.241
None		IN	A	206.159.101.242
None		IN	A	65.173.211.241
None		IN	A	206.159.101.241
None		IN	A	65.173.211.241
None		IN	A	206.159.101.242
None		IN	CNAME	irsolutions.snl.com.
None		IN	CNAME	sprint.tekgroupweb.com.
None		IN	TXT	"google-site-verification=esN0caFOjX7L0Aw64GwZrc8H1KEZWIiiTawl1_pJ7aY"
None		IN	TXT	"sahmexeV1chnBSrFzrpRVXDMijq6dwCZOKF9yPlGD8wRolgTgePXCigAlANXyC45t5dHQf+uPxK4XaiOn7rf0g=="
None		IN	TXT	"v=spf1 include:spfa.sprint.com include:spfb.sprint.com -all"
; EOF