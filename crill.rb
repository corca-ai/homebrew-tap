# typed: false
# frozen_string_literal: true

# This file is rendered by .github/workflows/release.yml from
# scripts/release/crill.rb.template in the corca-ai/crill repo.
# Do not edit the tap copy directly; edit the template and cut a new
# release tag.
class Crill < Formula
  desc "Mobile app UX exploration and competitive change detection CLI"
  homepage "https://github.com/corca-ai/crill-cli"
  version "0.2.3"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/corca-ai/crill-cli/releases/download/v0.2.3/crill_0.2.3_darwin_amd64.tar.gz"
      sha256 "51731ae819467ddf4221231be32126dd1059dbdbea5db9ad565afe4a6dcfdea5"

      def install
        bin.install "crill"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/corca-ai/crill-cli/releases/download/v0.2.3/crill_0.2.3_darwin_arm64.tar.gz"
      sha256 "18405c5809b23a3ba7f0a3228ee2621cd587988803edfad3e7f4e16fd6f11016"

      def install
        bin.install "crill"
      end
    end
  end

  test do
    system bin/"crill", "--version"
  end
end
