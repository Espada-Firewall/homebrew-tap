# typed: false
# frozen_string_literal: true

# Espada — a self-hosted control plane for running AI privately on your own infrastructure.
#
# This formula installs a pre-built, platform-specific tarball published
# to this tap's GitHub releases. The tarball is fully self-contained —
# it ships with `node_modules/` already vendored — so `brew install`
# runs no `pnpm install` or postinstall scripts.
#
# Releases are cut by the source repo's `scripts/publish-tap-release.mjs`,
# which builds the tarball, attaches it to a `vX.Y.Z` GitHub release on
# this repo, then bumps `version` + `sha256` below and pushes.

class Espada < Formula
  desc "Self-hosted control plane for running AI privately on your own infrastructure"
  homepage "https://github.com/Espada-Firewall/homebrew-tap"
  version "2026.1.69"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Espada-Firewall/homebrew-tap/releases/download/v#{version}/espada-#{version}-darwin-arm64.tar.gz"
      sha256 "5782f05dc2c438fa28995306b2361af1efd2c3a8f0c47af2ce7409288926e2cf"
    end
  end

  depends_on "node@22"
  depends_on arch: :arm64
  depends_on :macos

  def install
    libexec.install Dir["*"]
    (bin/"espada").write <<~SH
      #!/bin/bash
      exec "#{Formula["node@22"].opt_bin}/node" "#{libexec}/espada.mjs" "$@"
    SH
    chmod 0755, bin/"espada"
  end

  def caveats
    <<~EOS
      Espada stores its config under ~/.espada and its workspace under
      ~/espada by default. Run the first-time wizard with:

          espada setup

      To start a local Gateway in dev mode:

          espada --dev gateway --force

      Documentation: https://espadafirewall.com
    EOS
  end

  test do
    assert_match(/\d+\.\d+\.\d+/, shell_output("#{bin}/espada --version"))
  end
end
