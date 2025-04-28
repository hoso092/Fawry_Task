# 🛠️ DNS and Network Troubleshooting Guide
This guide explains common reasons why an internal service like internal.example.com could become unreachable, and how to troubleshoot and fix each issue.
# 📚 Common DNS Issues and Solutions
#### 1. DNS Server is Unreachable
How to Confirm:

`$ dig internal.example.com`

If the DNS server is unreachable, you will see:

`;; connection timed out; no servers could be reached`
Solution:

`sudo systemctl restart systemd-resolved`

#### 2.  DNS Record Missing or Incorrect
How to Confirm:

`$ dig internal.example.com`

If the DNS record is missing or incorrect, you will see:

`;; connection timed out; no servers could be reached`
Solution:
`sudo systemctl restart systemd-resolved`
#### 3. `/etc/resolv.conf` Misconfigured
How to Confirm:
`$ cat /etc/resolv.conf`
If the file is misconfigured, you will see:
`nameserver 127.0.0.53`
`options edns0`
Solution:
Add:
`nameserver 192.168.1.10`

# 🌐 Common Network Layer Issues and Solutions

#### 1. Firewall Blocking DNS or Web Traffic
Solution:
``
sudo ufw allow 53/tcp``
``sudo ufw allow 53/udp``
``sudo ufw allow 80/tcp``
``sudo ufw allow 443/tcp``

#### 2. Routing Issues
How to Confirm:
`traceroute internal.example.com`
Solution:
`sudo ip route add default via 192.168.1.1`

# 🔥 Common Service-Side Issues and Solutions
#### 1. Service is Down or Unresponsive
How to Confirm:
`sudo systemctl status <service-name>`
`sudo netstat -tuln | grep :80`
`sudo netstat -tuln | grep :443`
Solution:
 For Apache
``sudo systemctl reload apache2``
``sudo systemctl restart apache2``
``sudo systemctl restart nginx`` for Nginx 

#### 2. Server IP Changed Without DNS Update
How to Confirm:
`dig internal.example.com`
`ssh user@internal-server`
`ip addr`
Check if the IP address matches the DNS records.
Solution: Update the DNS records manually:
`sudo vim /etc/bind/db.example.com`
Restart the DNS server:
`sudo systemctl restart bind9`
