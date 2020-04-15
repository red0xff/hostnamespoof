
# What is it for

hostnamespoof is a simple program that aims to change the Linux hostname randomly (using a given hostname generator program), it can be ran as a commandline tool, or installed as a systemd service to run at each boot.
 
# Why?

Hostnames are public information, they are sent part of DHCP messages for example, or NetBIOS responses, and can reveal the identity of a machine on local area networks.

In order to hide any information that could reveal the identity of users in a LAN, people use `macchanger` to spoof MAC addresses, I thought it could be useful for some people to also get random hostnames at each boot / when needed.

# How to use

- Run `install.sh` as root, giving it the path to your program that generates hostnames (to use the existing docker_container_names.go, build it with: `go build docker_container_names.go`).

- The installation directory is /usr/share/hostnamespoof/, execute the `spoof_hostname.sh` script in that directory to get a random hostname

# Current Hostname generators

- docker_container_names.go : The exact name generator Docker uses for container names

Contributions are welcome

# What are valid hostnames

From `man 7 hostname`:

```
       Hostnames are domains, where a domain is a hierarchical, dot-
       separated list of subdomains; for example, the machine "monet", in
       the "example" subdomain of the "com" domain would be represented as
       "monet.example.com".

       Each element of the hostname must be from 1 to 63 characters long and
       the entire hostname, including the dots, can be at most 253
       characters long.  Valid characters for hostnames are ASCII(7) letters
       from a to z, the digits from 0 to 9, and the hyphen (-).  A hostname
       may not start with a hyphen.
```

