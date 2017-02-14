openwrt-vlmcsd

A OpenWRT package for vlmcsd


luci-app-vlmcsd: [luci-app-vlmcsd](https://github.com/cokebar/luci-app-vlmcsd "")

luci-app-vlmscd support KMS auto activation.

If you don't use luci-app-vlmcsd and you want vlmcsd support KMS auto activation, you should modify the settings of dnsmasq manually:

1. Add the following line at the end of "/etc/dnsmasq.conf":

   srv-host=_vlmcs._tcp.lan,hostname.lan,1688,0,100
   
   (replace "hostname.lan" with your actual host name, eg: openwrt.lan, or just replace it with your IP of LAN）

2. Restart dnsmasq:

   /etc/init.d/dnsmasq restart

   You can check if the dnsmasq setting works with the following cammand in Windows:
   
   nslookup -type=srv _vlmcs._tcp.lan
   
   The response should be your router's IP.

3. /etc/init.d/vlmcsd enable && /etc/init.d/vlmcsd start && /etc/init.d/dnsmasq restart

Your can find pre-compile ipk here: https://github.com/cokebar/openwrt-vlmcsd/tree/gh-pages
