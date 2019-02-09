# OpenVPN on Docker with keys baked-in

Builds on top of: https://github.com/kylemanna/docker-openvpn

```
mkdir vpn-data
cd vpn-data
```

# Init keys
Replace IP and enter password

```
docker run -v /home/ian/git/docker-openvpn/vpn-data:/etc/openvpn --log-driver=none --rm kylemanna/openvpn:2.4 ovpn_genconfig -u udp://34.254.7.172
docker run -v /home/ian/git/docker-openvpn/vpn-data:/etc/openvpn --log-driver=none --rm -it kylemanna/openvpn:2.4 ovpn_initpki
```

# Bake keys into image for convience (trust Docker repo)
```
sudo chmod -R a+rx pki
docker build -t ovpn
```

# To Debug: 
```
docker run -v /home/ian/git/docker-openvpn/vpn-data:/etc/openvpn -d -p 1194:1194/udp --cap-add=NET_ADMIN ovpn

docker run -ti --rm -p 1194:1194/udp --cap-add=NET_ADMIN ovpn

docker run -ti --rm -p 1194:1194/udp --cap-add=NET_ADMIN 811227613105.dkr.ecr.eu-west-1.amazonaws.com/ovpn:20190209
```

# Generate client cert
docker run -v /home/ian/git/docker-openvpn/vpn-data:/etc/openvpn --log-driver=none --rm -it kylemanna/openvpn:2.4 easyrsa build-client-full CLIENTNAME nopass

docker run -v /home/ian/git/docker-openvpn/vpn-data:/etc/openvpn --log-driver=none --rm kylemanna/openvpn:2.4 ovpn_getclient CLIENTNAME > CLIENTNAME.ovpn