# typed: false
# frozen_string_literal: true

# This file is rendered by scripts/release/publish_release.py in the
# corca-ai/crill-cli repo. Do not edit the tap copy directly; edit the
# public-repo template in corca-ai/crill and cut a new release tag.
class Crill < Formula
  desc "Mobile app UX exploration and competitive change detection CLI"
  homepage "https://github.com/corca-ai/crill-cli"
  version "0.3.0"
  depends_on arch: :arm64

  on_macos do
    url "https://github.com/corca-ai/crill-cli/releases/download/v0.3.0/crill_0.3.0_darwin_arm64.tar.gz"
    sha256 "8ca24d8f982c07837c83fc5677d6ec6127558aa7f62e209bb3acfccb31a60a4b"

    def install
      bin.install "crill"
    end
  end

  test do
    system bin/"crill", "--version"
  end
end
