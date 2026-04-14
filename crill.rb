# typed: false
# frozen_string_literal: true

# This file is rendered by scripts/release/publish_release.py in the
# corca-ai/crill-cli repo. Do not edit the tap copy directly; edit the
# public-repo template in corca-ai/crill and cut a new release tag.
class Crill < Formula
  desc "Mobile app UX exploration and competitive change detection CLI"
  homepage "https://github.com/corca-ai/crill-cli"
  version "0.4.0"
  depends_on arch: :arm64

  on_macos do
    url "https://github.com/corca-ai/crill-cli/releases/download/v0.4.0/crill_0.4.0_darwin_arm64.tar.gz"
    sha256 "d67d3cf3b909c9d5d98f60d4d7c836349693fc8103ad7eac0947c36bad8b3a85"

    def install
      bin.install "crill"
    end
  end

  test do
    system bin/"crill", "--version"
  end
end
