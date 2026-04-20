# typed: false
# frozen_string_literal: true

# This file is rendered by scripts/release/publish_release.py in the
# corca-ai/crill-cli repo. Do not edit the tap copy directly; edit the
# public-repo template in corca-ai/crill and cut a new release tag.
class Crill < Formula
  desc "Mobile app UX exploration and competitive change detection CLI"
  homepage "https://github.com/corca-ai/crill-cli"
  version "0.4.1"
  depends_on arch: :arm64

  on_macos do
    url "https://github.com/corca-ai/crill-cli/releases/download/v0.4.1/crill_0.4.1_darwin_arm64.tar.gz"
    sha256 "d495b21654f7cffbcd7dfd127688bac1372cae93717a84a8e69e98bfdd18ca12"

    def install
      bin.install "crill"
    end
  end

  test do
    system bin/"crill", "--version"
  end
end
