# VPN-Google-auth

This small script aims to facilitate access to a vpn, which has Google two-step authentication in command line.

## Getting started

### Packages that you need

###### *1. OpenVPN*
`$ sudo apt-get install openvpn` or  `$ sudo yum install openvpn`

**Note:** For OSX you should follow this [tutorial](https://my.hostvpn.com/knowledgebase/29/OpenVPN-on-Mac-OS-X-via-Homebrew-CLI.html "tutorial")

###### *2. Expect*
`$ sudo apt-get install expect` or  `$ sudo yum install expect`

**Note:** For OSX you can try with HomeBrew

### Configuration

The script was designed to read the vpn.properties, just fill the correct information on each key.

Example

```
vpn.user=pepe
vpn.password=pepe1234
vpn.path=/home/pepe/vpn/
vpn.fileName=pepe-server-client.ovpn
```

## Execution

To execute the script, you should use sudo privileges

`sudo ./connect_vpn.sh`

### If some problem occurs

The scripts should be in same group with the login user but depending for your distro sometimes each script could has an unknown group.

You can fix with this command:

`chown user:user file` and `chmod +x file`

Example

`chown pepe:pepe connect_vpn.sh` and  `chmod +x connect_vpn.sh`
