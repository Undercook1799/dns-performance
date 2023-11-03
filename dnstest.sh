#!/usr/bin/env bash


command -v bc > /dev/null || { echo "error: bc was not found. Please install bc."; exit 1; }
{ command -v drill > /dev/null && dig=drill; } || { command -v dig > /dev/null && dig=dig; } || { echo "error: dig was not found. Please install dnsutils."; exit 1; }


NAMESERVERS=`cat /etc/resolv.conf | grep ^nameserver | cut -d " " -f 2 | sed 's/\(.*\)/&#&/'`

PROVIDERSV4="
1.1.1.1#cloudflare
9.9.9.9#quad9
94.140.14.14#adguard-def
76.76.2.2#controld-ad
194.242.2.3#mullvad-ad
185.222.222.222#dns.sb
193.110.81.0#dns0.eu
45.90.28.0#nextdns
"

PROVIDERSV6="
2606:4700:4700::1111#cloudflare
2620:fe::fe#quad9
2a10:50c0::ad1:ff#adguard-def
2606:1a40::2#controld-ad
2a07:e340::3#mullvad-ad
2a09::#dns.sb
2a0f:fc80::#dns0.eu
2a07:a8c0::#nextdns
"

# Testing for IPv6
$dig +short +tries=1 +time=2 +stats @2a0d:2a00:1::1 www.google.com |grep 216.239.38.120 >/dev/null 2>&1
if [ $? = 0 ]; then
    hasipv6="true"
fi

providerstotest=$PROVIDERSV4

if [ "x$1" = "xipv6" ]; then
    if [ "x$hasipv6" = "x" ]; then
        echo "error: IPv6 support not found. Unable to do the ipv6 test."; exit 1;
    fi
    providerstotest=$PROVIDERSV6

elif [ "x$1" = "xipv4" ]; then
    providerstotest=$PROVIDERSV4

elif [ "x$1" = "xall" ]; then
    if [ "x$hasipv6" = "x" ]; then
        providerstotest=$PROVIDERSV4
    else
        providerstotest="$PROVIDERSV4 $PROVIDERSV6"
    fi
else
    providerstotest=$PROVIDERSV4
fi

    

# Domains to test. Duplicated domains are ok
DOMAINS2TEST="www.google.com www.amazon.com www.facebook.com www.youtube.com www.reddit.com  wikipedia.org twitter.com gmail.com duckduckgo.com github.com www.cloudflare.com abc7news.com"


totaldomains=0
printf "%-21s" ""
for d in $DOMAINS2TEST; do
    totaldomains=$((totaldomains + 1))
    printf "%-8s" "test$totaldomains"
done
printf "%-8s" "Average"
echo ""


for p in $NAMESERVERS $providerstotest; do
    pip=${p%%#*}
    pname=${p##*#}
    ftime=0

    printf "%-21s" "$pname"
    for d in $DOMAINS2TEST; do
        ttime=`$dig +tries=1 +time=2 +stats @$pip $d |grep "Query time:" | cut -d : -f 2- | cut -d " " -f 2`
        if [ -z "$ttime" ]; then
	        #let's have time out be 1s = 1000ms
	        ttime=1000
        elif [ "x$ttime" = "x0" ]; then
	        ttime=1
	    fi

        printf "%-8s" "$ttime ms"
        ftime=$((ftime + ttime))
    done
    avg=`bc -l <<< "scale=2; $ftime/$totaldomains"`

    echo "  $avg"
done


exit 0;
