; Zone File for aafes.com
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
		IN	NS	legolas.aafes.com.
		IN	NS	aragorn.aafes.com.
		IN	MX	None aafes.com
		IN	MX	None aafes.com
None		IN	A	199.67.0.85
None		IN	A	199.67.0.86
None		IN	A	199.67.0.87
None		IN	A	199.67.2.26
None		IN	A	199.67.4.26
None		IN	A	199.67.4.26
None		IN	TXT	"MS=ms19886014"
None		IN	TXT	"v=spf1 ip4:199.67.7.205 ip4:199.67.7.206 ip4:199.67.7.89 ip4:199.67.7.6 ip4:199.67.7.7 ip4:199.67.5.250 ip4:199.67.5.251 ip4:199.67.5.215 ip4:199.67.5.216 ip4:199.67.5.217 ip4:199.67.5.218 include:outlook.com include:spf.messaging.microsoft.com ~all"
None		IN	TXT	"kvPI6yxV+EZDt6Ri4CN8ut4s3cqvLq1zXwZQL+xIbsYZRgN1D6PMRsaJLd1fLMGbz+ofzRMQrd2ejKdEmX1+EA=="
; EOF