FROM kylemanna/openvpn:2.4

ADD pki /etc/openvpn/pki
ADD ccd /etc/openvpn/ccd
ADD crl.pem /etc/openvpn/crl.pem
ADD openvpn.conf /etc/openvpn/openvpn.conf
ADD ovpn_env.sh /etc/openvpn/ovpn_env.sh

CMD ["ovpn_run"]