class Proxyguardclient < Formula
  desc "Proxyguard-Client"
  homepage "https://codeberg.org/eduVPN/proxyguard/"
  url "https://codeberg.org/eduVPN/proxyguard/releases/download/2.0.0/proxyguard-2.0.0.tar.xz"
  version "2.0.0"
  sha256 "ef89d421d0b684374f04510cdc3136a3c2561de03605a59c773ef7c18a60230d"
  depends_on "go"

  def install
    system "/opt/homebrew/bin/go build -o proxyguard-client codeberg.org/eduVPN/proxyguard/cmd/proxyguard-client/..."
    bin.install "proxyguard-client"

    # Download the wrapper script from the GitHub repository
    wrapper_script_url = "https://raw.githubusercontent.com/freifunkMUC/homebrew-proxyguard-client/main/macos-os-proxyguard-wrapper.sh"
    system "curl", "-o", "macos-os-proxyguard-wrapper.sh", wrapper_script_url unless File.exist?("macos-os-proxyguard-wrapper.sh")
    bin.install "macos-os-proxyguard-wrapper.sh" => "proxyguard-wrapper"
  end
end