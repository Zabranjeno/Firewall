@echo off
:: Batch script to configure Windows Firewall rules
:: Run this script in an elevated Command Prompt
:: Owner: Gorstak

:: Reset Windows Firewall to default (optional, comment out if not desired)
netsh advfirewall reset

:: Set default policies: block all inbound, allow specified outbound
netsh advfirewall set allprofiles state on
netsh advfirewall set allprofiles firewallpolicy blockinbound,allowoutbound

:: === SYSTEM Rules ===
:: NetBIOS Datagrams (UDP 137-138)
netsh advfirewall firewall add rule name="NetBIOS Datagrams Inbound" dir=in action=block protocol=UDP localport=137-138 remoteport=137-138 profile=any

:: Microsoft DS (TCP 445)
netsh advfirewall firewall add rule name="Microsoft DS Client Outbound" dir=out action=block protocol=TCP localport=1024-65535 remoteport=445 profile=any
netsh advfirewall firewall add rule name="Microsoft DS Server Inbound" dir=in action=block protocol=TCP localport=445 remoteport=1024-65535 profile=any

:: NetBIOS Sessions (TCP 139)
netsh advfirewall firewall add rule name="NetBIOS Sessions Client Outbound" dir=out action=block protocol=TCP localport=1024-65535 remoteport=139 profile=any
netsh advfirewall firewall add rule name="NetBIOS Sessions Server Inbound" dir=in action=block protocol=TCP localport=139 remoteport=1024-65535 profile=any

:: ICMP Incoming (specific types)
netsh advfirewall firewall add rule name="ICMP Incoming" dir=in action=block protocol=ICMPv4 type=8 profile=any
netsh advfirewall firewall add rule name="ICMP Outgoing" dir=out action=block protocol=ICMPv4 type=8 profile=any

:: ICMPv6 Error and Info Messages
netsh advfirewall firewall add rule name="ICMPv6 Error Messages" dir=in action=block protocol=ICMPv6 type=1,2,3,4 profile=any
netsh advfirewall firewall add rule name="ICMPv6 Info Messages" dir=in action=block protocol=ICMPv6 type=128,129,133,134,135,136,137 profile=any

:: 6to4 Tunnel (Protocol 41)
netme advfirewall firewall add rule name="6to4 Tunnel IPv6" dir=in action=block protocol=41 profile=any

:: Teredo Tunnel (UDP 3544-3545)
netsh advfirewall firewall add rule name="Teredo Tunnel Outbound" dir=out action=block protocol=UDP localport=0-65535 remoteport=3544-3545 profile=any

:: RDP (TCP 3389)
netsh advfirewall firewall add rule name="RDP Inbound" dir=in action=block protocol=TCP localport=3389 remoteport=1024-65535 profile=any

:: PPTP (TCP 1723, GRE)
netsh advfirewall firewall add rule name="PPTP Call Control Outbound" dir=out action=block protocol=TCP localport=1024-65535 remoteport=1723 profile=any
netsh advfirewall firewall add rule name="PPTP GRE" dir=in action=block protocol=47 profile=any

:: UPnP (UDP 1900)
netsh advfirewall firewall add rule name="UPnP Inbound" dir=in action=block protocol=UDP localport=1900 remoteport=1-65535 profile=any
netsh advfirewall firewall add rule name="UPnP Outbound" dir=out action=block protocol=UDP localport=1-65535 remoteport=1900 profile=any

:: IGMP (Protocol 2)
netsh advfirewall firewall add rule name="IGMP" dir=in action=block protocol=2 profile=any

:: === Application-Specific Rules ===

:: iexplore.exe
netsh advfirewall firewall add rule name="iexplore HTTP Outbound" dir=out action=block protocol=TCP localport=1024-65535 remoteport=80-88 program="C:\Program Files\Internet Explorer\iexplore.exe" profile=any
netsh advfirewall firewall add rule name="iexplore Alt HTTP1 Outbound" dir=out action=block protocol=TCP localport=1024-65535 remoteport=8000-8008 program="C:\Program Files\Internet Explorer\iexplore.exe" profile=any
netsh advfirewall firewall add rule name="iexplore Alt HTTP2 Outbound" dir=out action=block protocol=TCP localport=1024-65535 remoteport=8080-8088 program="C:\Program Files\Internet Explorer\iexplore.exe" profile=any
netsh advfirewall firewall add rule name="iexplore HTTPS Outbound" dir=out action=block protocol=TCP localport=1024-65535 remoteport=443 program="C:\Program Files\Internet Explorer\iexplore.exe" profile=any
netsh advfirewall firewall add rule name="iexplore Proxy Outbound" dir=out action=block protocol=TCP localport=1024-65535 remoteport=3128 program="C:\Program Files\Internet Explorer\iexplore.exe" profile=any
netsh advfirewall firewall add rule name="iexplore FTP Outbound" dir=out action=block protocol=TCP localport=1024-65535 remoteport=21 program="C:\Program Files\Internet Explorer\iexplore.exe" profile=any

:: SystemSettings.exe
netsh advfirewall firewall add rule name="SystemSettings HTTP Outbound" dir=out action=block protocol=TCP localport=1024-65535 remoteport=80 program="C:\Windows\ImmersiveControlPanel\SystemSettings.exe" profile=any
netsh advfirewall firewall add rule name="SystemSettings HTTPS Outbound" dir=out action=block protocol=TCP localport=1024-65535 remoteport=443 program="C:\Windows\ImmersiveControlPanel\SystemSettings.exe" profile=any

:: explorer.exe
netsh advfirewall firewall add rule name="explorer HTTP Outbound" dir=out action=block protocol=TCP localport=1024-65535 remoteport=80-88 program="C:\Windows\explorer.exe" profile=any
netsh advfirewall firewall add rule name="explorer Alt HTTP1 Outbound" dir=out action=block protocol=TCP localport=1024-65535 remoteport=8000-8008 program="C:\Windows\explorer.exe" profile=any
netsh advfirewall firewall add rule name="explorer Alt HTTP2 Outbound" dir=out action=block protocol=TCP localport=1024-65535 remoteport=8080-8088 program="C:\Windows\explorer.exe" profile=any
netsh advfirewall firewall add rule name="explorer HTTPS Outbound" dir=out action=block protocol=TCP localport=1024-65535 remoteport=443 program="C:\Windows\explorer.exe" profile=any
netsh advfirewall firewall add rule name="explorer Proxy Outbound" dir=out action=block protocol=TCP localport=1024-65535 remoteport=3128 program="C:\Windows\explorer.exe" profile=any

:: ftp.exe
netsh advfirewall firewall add rule name="ftp Command Outbound" dir=out action=block protocol=TCP localport=1024-65535 remoteport=21 program="C:\Windows\system32\ftp.exe" profile=any

:: lsass.exe
netsh advfirewall firewall add rule name="lsass DNS Outbound" dir=out action=block protocol=TCP localport=1024-65535 remoteport=53 program="C:\Windows\System32\lsass.exe" profile=any
netsh advfirewall firewall add rule name="lsass Kerberos UDP Out" dir=out action=block protocol=UDP localport=1024-65535 remoteport=88 program="C:\Windows\System32\lsass.exe" profile=any
netsh advfirewall firewall add rule name="lsass Kerberos UDP In" dir=in action=block protocol=UDP localport=88 remoteport=1024-65535 program="C:\Windows\System32\lsass.exe" profile=any
netsh advfirewall firewall add rule name="lsass Kerberos TCP Out" dir=out action=block protocol=TCP localport=1024-65535 remoteport=88 program="C:\Windows\System32\lsass.exe" profile=any
netsh advfirewall firewall add rule name="lsass Kerberos TCP In" dir=in action=block protocol=TCP localport=88 remoteport=1024-65535 program="C:\Windows\System32\lsass.exe" profile=any
netsh advfirewall firewall add rule name="lsass Location Service TCP Out" dir=out action=block protocol=TCP localport=1024-65535 remoteport=135 program="C:\Windows\System32\lsass.exe" profile=any
netsh advfirewall firewall add rule name="lsass Location Service UDP Out" dir=out action=block protocol=UDP localport=1024-65535 remoteport=135 program="C:\Windows\System32\lsass.exe" profile=any
netsh advfirewall firewall add rule name="lsass Dynamic RPC Out" dir=out action=block protocol=TCP localport=1024-65535 remoteport=1026 program="C:\Windows\System32\lsass.exe" profile=any
netsh advfirewall firewall add rule name="lsass LDAP UDP Out" dir=out action=block protocol=UDP localport=1024-65535 remoteport=389 program="C:\Windows\System32\lsass.exe" profile=any
netsh advfirewall firewall add rule name="lsass LDAP UDP In" dir=in action=block protocol=UDP localport=389 remoteport=1024-65535 program="C:\Windows\System32\lsass.exe" profile=any