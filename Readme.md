# OpenVPN on Docker with keys baked-in

Useful for spinning up pre-configured OpenVPN server on-demand with a trusted/secure Docker repo.

Builds on top of: https://github.com/kylemanna/docker-openvpn
(Read the doc there first)

```
mkdir vpn-data
cd vpn-data
```

# Init keys
Replace IP and enter password

```
docker run -v /home/ian/git/openvpn-full-docker:/etc/openvpn --log-driver=none --rm kylemanna/openvpn:2.4 ovpn_genconfig -u udp://34.254.7.172
docker run -v /home/ian/git/openvpn-full-docker:/etc/openvpn --log-driver=none --rm -it kylemanna/openvpn:2.4 ovpn_initpki
```

# Bake keys into image for convience (trust Docker repo)
```
sudo chmod -R a+rx pki
sudo chmod -R a+rx ovpn_env.sh
docker build -t ovpn .
```

# To Debug: 
```

docker run -ti --rm -p 1194:1194/udp --cap-add=NET_ADMIN ovpn

```

# Generate client cert
docker run --log-driver=none --rm -it ovpn easyrsa build-client-full CLIENTNAME nopass

docker run --log-driver=none --rm ovpn ovpn_getclient CLIENTNAME > CLIENTNAME.ovpn
