# Homebrew Proxyguard Client Formula

This repository contains the Homebrew formula for installing the Proxyguard Client, a tool for managing proxy configurations.

## About

The Proxyguard Client depends on [Proxyguard](https://codeberg.org/eduVPN/proxyguard), a project designed to enable secure and flexible proxy configurations. This tool is particularly useful in scenarios where UDP traffic is not allowed, and you need to use TCP/HTTPS traffic to work around Internet restrictions or limitations, such as in guest WLANs.

## Installation

To install the Proxyguard Client using Homebrew, run the following command:

```bash
brew tap freifunkmuc/homebrew-proxyguard-client
brew install proxyguardclient
```

## Usage

After installation, you can use the Proxyguard Client and its wrapper script as follows:

### Using the Wrapper Script

The wrapper script simplifies setting up routes and running the Proxyguard Client. To use it, provide the VPN gateway as an argument:

```bash
proxyguard-wrapper <VPN_GATEWAY>
```

For example, to use the VPN gateway `rw-vpn02.ext.ffmuc.net`:

```bash
proxyguard-wrapper rw-vpn02.ext.ffmuc.net
```

The script will:
1. Resolve the IPv4 and IPv6 addresses of the VPN gateway.
2. Add the necessary routes to the system.
3. Start the Proxyguard Client to forward traffic to the VPN gateway.
4. Automatically clean up routes when the process exits.

### Running the Proxyguard Client Directly

If you prefer to run the Proxyguard Client directly, use the following command:

```bash
proxyguard-client --to "https://<VPN_GATEWAY>" --forward-port 51299
```

Replace `<VPN_GATEWAY>` with the address of your VPN gateway.

### Configuring WireGuard

To use the Proxyguard Client with WireGuard, you need to modify your local WireGuard configuration file. 

1. In the `[Interface]` section, add the following line:
   ```ini
   ListenPort = 51299
   ```

2. Under the `[Peer]` section, change the `Endpoint` to:
   ```ini
   Endpoint = 127.0.0.1:51821
   ```

These changes ensure that WireGuard listens on the correct port and forwards traffic through the Proxyguard Client.

## Development

If you want to modify the formula or contribute to its development:

1. Clone this repository:
   ```bash
   git clone https://github.com/freifunkMUC/homebrew-proxyguard-client.git
   cd homebrew-proxyguard-client
   ```

2. Edit the formula located at `Formula/proxyguardclient.rb`.

3. Test the formula locally:
   ```bash
   brew install --build-from-source Formula/proxyguardclient.rb
   ```

## Troubleshooting

If you encounter issues such as missing files (e.g., `macos-os-proxyguard-wrapper.sh`), ensure that the script is available in the source tarball or downloaded during installation.

## License

This project is licensed under the [MIT License](LICENSE).
