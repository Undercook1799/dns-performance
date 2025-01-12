# What is this?

Shell script to test the performance of DNS resolvers from your location.

# What's Changed From The Original Repository?

Modified Stuff from the [original](https://github.com/cleanbrowsing/dnsperftest):

- Changed default included servers to:

  - Cloudflare's 1.1.1.1 & 2606:4700:4700::1111
  - Quad9's 9.9.9.9 & 2620:fe::fe
  - Adguard's Default 94.140.14.14 & 2a10:50c0::ad1:ff
  - ControlD's Ad & Tracking 76.76.2.2 & 2606:1a40::2
  - Mullvad's Adblock 194.242.2.3 & 2a07:e340::3
  - DNS.SB's 185.222.222.222 & 2a09::
  - dns0.eu's 193.110.81.0 & 2a0f:fc80::
  - NextDNS's 45.90.28.0 & 2a07:a8c0::

- Changed two test servers:
  - From the second google.com domain to duckduckgo.com
  - From whatsapp.com to github.com

- Added test servers:
  - www.cloudflare.com
  - abc7news.com

# Required

You need to install bc and dig (which may or may not already be included with your distro).

For Ubuntu:

```
 $ sudo apt-get install bc dnsutils
```

For macOS using homebrew:

```
 $ brew install bc bind
```

# Utilization

```
 $ git clone --depth=1 https://github.com/Undercook1799/dnsperftest/
 $ cd dnsperftest
 $ bash ./dnstest.sh
               test1   test2   test3   test4   test5   test6   test7   test8   test9   test10  Average
cloudflare     1 ms    1 ms    1 ms    2 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms      1.10
google         22 ms   1 ms    4 ms    24 ms   1 ms    19 ms   3 ms    56 ms   21 ms   21 ms     17.20
quad9          10 ms   19 ms   10 ms   10 ms   10 ms   10 ms   10 ms   10 ms   10 ms   55 ms     15.40
opendns        39 ms   2 ms    2 ms    20 ms   2 ms    72 ms   2 ms    39 ms   39 ms   3 ms      22.00
norton         2 ms    2 ms    2 ms    2 ms    1 ms    2 ms    2 ms    1 ms    2 ms    2 ms      1.80
cleanbrowsing  11 ms   14 ms   11 ms   11 ms   10 ms   10 ms   11 ms   36 ms   11 ms   13 ms     13.80
yandex         175 ms  209 ms  175 ms  181 ms  188 ms  179 ms  178 ms  179 ms  177 ms  208 ms    184.90
adguard        200 ms  200 ms  200 ms  199 ms  202 ms  200 ms  202 ms  200 ms  199 ms  248 ms    205.00
neustar        2 ms    2 ms    2 ms    2 ms    1 ms    2 ms    2 ms    2 ms    2 ms    2 ms      1.90
comodo         21 ms   22 ms   22 ms   22 ms   22 ms   22 ms   22 ms   21 ms   22 ms   24 ms     22.00
```

To sort with the fastest first, add `sort -k 22 -n` at the end of the command:

```
  $ bash ./dnstest.sh |sort -k 22 -n
               test1   test2   test3   test4   test5   test6   test7   test8   test9   test10  Average
cloudflare     1 ms    1 ms    1 ms    4 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms      1.30
norton         2 ms    2 ms    2 ms    2 ms    2 ms    2 ms    2 ms    2 ms    2 ms    2 ms      2.00
neustar        2 ms    2 ms    2 ms    2 ms    1 ms    2 ms    2 ms    2 ms    2 ms    22 ms     3.90
cleanbrowsing  11 ms   23 ms   11 ms   11 ms   11 ms   11 ms   11 ms   13 ms   12 ms   11 ms     12.50
google         4 ms    4 ms    3 ms    21 ms   21 ms   61 ms   3 ms    21 ms   21 ms   22 ms     18.10
opendns        2 ms    2 ms    2 ms    39 ms   2 ms    75 ms   2 ms    21 ms   39 ms   13 ms     19.70
comodo         22 ms   23 ms   22 ms   22 ms   22 ms   22 ms   22 ms   22 ms   22 ms   23 ms     22.20
quad9          10 ms   37 ms   10 ms   10 ms   10 ms   145 ms  10 ms   10 ms   10 ms   20 ms     27.20
yandex         177 ms  216 ms  178 ms  182 ms  186 ms  177 ms  183 ms  174 ms  186 ms  222 ms    188.10
adguard        199 ms  210 ms  200 ms  201 ms  202 ms  202 ms  199 ms  200 ms  198 ms  201 ms    201.20
```

To test using the IPv6 addresses, add the IPv6 option:

```
  $ bash ./dnstest.sh ipv6| sort -k 22 -n
                     test1   test2   test3   test4   test5   test6   test7   test8   test9   test10  Average
cleanbrowsing-v6     1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms      1.00
cloudflare-v6        1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    5 ms    1 ms    1 ms    1 ms      1.40
quad9-v6             1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    21 ms     3.00
8.8.8.8              7 ms    1 ms    16 ms   1 ms    1 ms    24 ms   1 ms    8 ms    1 ms    7 ms      6.70
neustar-v6           1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    60 ms     6.90
opendns-v6           1 ms    1 ms    1 ms    1 ms    1 ms    62 ms   1 ms    1 ms    29 ms   1 ms      9.90
google-v6            8 ms    8 ms    7 ms    8 ms    14 ms   67 ms   1 ms    7 ms    8 ms    61 ms     18.90
adguard-v6           52 ms   55 ms   52 ms   53 ms   52 ms   56 ms   52 ms   55 ms   52 ms   57 ms     53.60
yandex-v6            177 ms  178 ms  178 ms  179 ms  179 ms  178 ms  179 ms  178 ms  178 ms  223 ms    182.70
```

To test both IPv6 and IPv4, add the "all" option:

```
  $ bash ./dnstest.sh all| sort -k 22 -n
                     test1   test2   test3   test4   test5   test6   test7   test8   test9   test10  Average
cleanbrowsing        1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms      1.00
cleanbrowsing-v6     1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms      1.00
cloudflare-v6        1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms      1.00
neustar              1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms      1.00
nextdns              1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms      1.00
quad9-v6             1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms      1.00
cloudflare           1 ms    1 ms    1 ms    1 ms    1 ms    2 ms    1 ms    1 ms    1 ms    1 ms      1.10
quad9                1 ms    1 ms    1 ms    2 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms      1.10
google               1 ms    1 ms    6 ms    1 ms    1 ms    6 ms    1 ms    7 ms    9 ms    7 ms      4.00
8.8.8.8              6 ms    1 ms    25 ms   1 ms    1 ms    6 ms    1 ms    7 ms    1 ms    7 ms      5.60
neustar-v6           1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms    64 ms     7.30
opendns-v6           7 ms    1 ms    21 ms   8 ms    1 ms    1 ms    1 ms    6 ms    1 ms    29 ms     7.60
opendns              1 ms    1 ms    27 ms   27 ms   1 ms    67 ms   1 ms    6 ms    1 ms    27 ms     15.90
comodo               1 ms    1 ms    1 ms    1 ms    4 ms    1 ms    1 ms    1 ms    1 ms    150 ms    16.20
google-v6            7 ms    6 ms    33 ms   7 ms    7 ms    87 ms   7 ms    8 ms    8 ms    25 ms     19.50
level3               27 ms   26 ms   25 ms   27 ms   27 ms   25 ms   27 ms   27 ms   25 ms   28 ms     26.40
norton               28 ms   26 ms   28 ms   26 ms   26 ms   28 ms   27 ms   27 ms   27 ms   27 ms     27.00
adguard-v6           52 ms   54 ms   55 ms   56 ms   52 ms   52 ms   52 ms   53 ms   53 ms   54 ms     53.30
adguard              58 ms   58 ms   58 ms   58 ms   60 ms   58 ms   60 ms   60 ms   58 ms   60 ms     58.80
freenom              140 ms  140 ms  140 ms  145 ms  135 ms  140 ms  140 ms  140 ms  140 ms  134 ms    139.40
yandex-v6            178 ms  179 ms  178 ms  179 ms  178 ms  178 ms  178 ms  179 ms  179 ms  205 ms    181.10
yandex               178 ms  178 ms  177 ms  179 ms  178 ms  174 ms  180 ms  178 ms  179 ms  222 ms    182.30

```

# For Windows users using the Linux subsystem

If you receive an error `$'\r': command not found`, convert the file to a Linux-compatible line endings using:

    tr -d '\15\32' < dnstest.sh > dnstest-2.sh

Then run `bash ./dnstest-2.sh`

# iOS & MacOS Profiles

[https://github.com/Undercook1799/layer7-dns-profiles](https://github.com/Undercook1799/layer7-dns-profiles)
