# typed: false
# frozen_string_literal: true

# This file is rendered by scripts/release/publish_release.py in the
# corca-ai/crill-cli repo. Do not edit the tap copy directly; edit the
# public-repo template in corca-ai/crill and cut a new release tag.
class Crill < Formula
  desc "Mobile app UX exploration and competitive change detection CLI"
  homepage "https://github.com/corca-ai/crill-cli"
  version "0.5.6"
  depends_on arch: :arm64

  on_macos do
    url "https://github.com/corca-ai/crill-cli/releases/download/v0.5.6/crill_0.5.6_darwin_arm64.tar.gz"
    sha256 "110ae95caeef3d57d14fe409250b697f23ec96c7728e1f5b257f358dd3da81ac"

    def install
      libexec.install Dir["*"]
      bin.install_symlink libexec/"crill"
    end

    def post_install
      # Best-effort warm-up so the first operator launch after install or
      # upgrade does not also pay the cold-start bundle load cost. Keep the
      # install successful even if Gatekeeper or host policy blocks execution.
      quiet_system libexec/"crill", "--version"
    end
  end

  test do
    system bin/"crill", "--version"
  end
end
