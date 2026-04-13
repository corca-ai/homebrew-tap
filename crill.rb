# typed: false
# frozen_string_literal: true

# This file is rendered by .github/workflows/release.yml from
# scripts/release/crill.rb.template in the corca-ai/crill repo.
# Do not edit the tap copy directly; edit the template and cut a new
# release tag.
class Crill < Formula
  desc "Mobile app UX exploration and competitive change detection CLI"
  homepage "https://github.com/corca-ai/crill-cli"
  version "0.2.2"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/corca-ai/crill-cli/releases/download/v0.2.2/crill_0.2.2_darwin_amd64.tar.gz"
      sha256 "e1271be8aa254202200324b2379f16381546072ace7d95cc0887cc31a63547ed"

      def install
        bin.install "crill"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/corca-ai/crill-cli/releases/download/v0.2.2/crill_0.2.2_darwin_arm64.tar.gz"
      sha256 "695d7a892235a64b651db62651a5c45de85a026a00b6f1da36b4b8d30749a868"

      def install
        bin.install "crill"
      end
    end
  end

  test do
    system bin/"crill", "--version"
  end
end
