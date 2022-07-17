#!/bin/sh

if [ -z "$VPNADDR" -o -z "$VPNUSER" -o -z "$VPNPASS" -o -z "$CERTIFICATE" -o -z "$CERTIFICATEPASS"]; then
  echo "Variables VPNADDR, VPNUSER, VPNPASS, CERTIFICATE, CERTIFICATEPASS must be set."; exit;
fi

export VPNTIMEOUT=${VPNTIMEOUT:-30}


# Setup masquerade, to allow using the container as a gateway
for iface in $(ip a | grep eth | grep inet | awk '{print $2}'); do
  iptables -t nat -A POSTROUTING -s "$iface" -j MASQUERADE
done

while [ true ]; do
  echo "------------ VPN Starts ------------"
  /usr/bin/forticlient
  echo "------------ VPN exited ------------"
  sleep 10
done
