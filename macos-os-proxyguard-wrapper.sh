#!/bin/bash

set -e

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <VPN_GATEWAY>"
  exit 1
fi

VPN_GATEWAY=$1

# Resolve IPv4 and IPv6 addresses of the VPN gateway
VPN_IPV4=$(dig +short "$VPN_GATEWAY" A | head -n 1)
VPN_IPV6=$(dig +short "$VPN_GATEWAY" AAAA | head -n 1)

if [[ -z "$VPN_IPV4" && -z "$VPN_IPV6" ]]; then
  echo "Error: Unable to resolve IP addresses for $VPN_GATEWAY"
  exit 1
fi

# Get the default gateway
DEFAULT_GATEWAY=$(route -n get default | grep gateway | awk '{print $2}')
DEFAULT_GATEWAY6=$(route -n get -inet6 default | grep gateway | awk '{print $2}')

# Add routes if addresses are available
if [[ -n "$VPN_IPV4" && -n "$DEFAULT_GATEWAY" ]]; then
  echo "Adding IPv4 route for $VPN_IPV4"
  sudo route -nv add -net "$VPN_IPV4/32" "$DEFAULT_GATEWAY"
fi

if [[ -n "$VPN_IPV6" && -n "$DEFAULT_GATEWAY6" ]]; then
  echo "Adding IPv6 route for $VPN_IPV6"
  sudo route -nv add -inet6 -net "$VPN_IPV6/128" "$DEFAULT_GATEWAY6"
fi

# Run proxyguard-client
proxyguard-client --to "https://$VPN_GATEWAY" --forward-port 51299

# Cleanup function
cleanup() {
  echo "Cleaning up routes..."
  if [[ -n "$VPN_IPV4" && -n "$DEFAULT_GATEWAY" ]]; then
    sudo route -nv delete -net "$VPN_IPV4/32"
  fi
  if [[ -n "$VPN_IPV6" && -n "$DEFAULT_GATEWAY6" ]]; then
    sudo route -nv delete -inet6 -net "$VPN_IPV6/128"
  fi
}

# Trap EXIT to ensure cleanup is called
trap cleanup EXIT
