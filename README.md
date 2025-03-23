# Homebrew Proxyguard Client Formula

This repository contains the Homebrew formula for installing the Proxyguard Client, a tool for managing proxy configurations.

## Installation

To install the Proxyguard Client using Homebrew, run the following command:

```bash
brew tap freifunkmuc/homebrew-proxyguard-client
brew install proxyguardclient
```

## Usage

After installation, you can use the Proxyguard Client and its wrapper script as follows:

```bash
proxyguard-client
proxyguard-wrapper
```

## Development

If you want to modify the formula or contribute to its development:

1. Clone this repository:
   ```bash
   git clone https://github.com/freifunkMUC/homebrew-proxyguard-client.git
   cd homebrew-proxyguard-client
   ```

2. Edit the formula located at `Formular/proxyguardclient.rb`.

3. Test the formula locally:
   ```bash
   brew install --build-from-source Formular/proxyguardclient.rb
   ```

## Troubleshooting

If you encounter issues such as missing files (e.g., `macos-os-proxyguard-wrapper.sh`), ensure that the script is available in the source tarball or downloaded during installation.

## License

This project is licensed under the [MIT License](LICENSE).
