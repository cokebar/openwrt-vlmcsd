openwrt-vlmcsd
-----
#### An OpenWRT package for vlmcsd.

You can use [luci-app-vlmcsd](https://github.com/cokebar/luci-app-vlmcsd "") to control it. luci-app-vlmscd support KMS auto-activation.

Travis CI: [![Build Status](https://travis-ci.org/cokebar/openwrt-vlmcsd.svg?branch=master)](https://travis-ci.org/cokebar/openwrt-vlmcsd)

编译
---

从 OpenWrt 的 [SDK][openwrt-sdk] 编译  
```bash
# 解压下载好的 SDK
tar xjf OpenWrt-SDK-ar71xx-for-linux-x86_64-gcc-4.8-linaro_uClibc-0.9.33.2.tar.bz2
cd OpenWrt-SDK-ar71xx-*
# Clone 项目
git clone https://github.com/shadowsocks/luci-app-shadowsocks.git package/luci-app-shadowsocks
# 编译 po2lmo (如果有po2lmo可跳过)
pushd package/luci-app-shadowsocks/tools/po2lmo
make && sudo make install
popd
# 选择要编译的包 LuCI -> 3. Applications
make menuconfig
# 开始编译
make package/luci-app-shadowsocks/compile V=99
```
Using without luci-app-vlmcsd
-----
If you don't use luci-app-vlmcsd and you want vlmcsd support KMS auto activation, you should modify the settings of dnsmasq manually:

1. Add the following line at the end of `/etc/dnsmasq.conf`:

   `srv-host=_vlmcs._tcp.lan,hostname.lan,1688,0,100`
   
   (replace "hostname.lan" with your actual host name, eg: openwrt.lan, or just replace it with your IP of LAN）

2. Restart dnsmasq:

   `/etc/init.d/dnsmasq restart`

   You can check if the dnsmasq setting works with the following cammand in Windows:
   
   `nslookup -type=srv _vlmcs._tcp.lan`
   
   The response should be your router's IP.

3. `/etc/init.d/vlmcsd enable && /etc/init.d/vlmcsd start && /etc/init.d/dnsmasq restart`

Pre-compiled Download
-----
Your can find pre-compiled ipk:
https://github.com/cokebar/openwrt-vlmcsd/tree/gh-pages
