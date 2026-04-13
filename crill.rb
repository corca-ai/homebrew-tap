# typed: false
# frozen_string_literal: true

# This file is rendered by .github/workflows/release.yml from
# scripts/release/crill.rb.template in the corca-ai/crill repo.
# Do not edit the tap copy directly; edit the template and cut a new
# release tag.
class Crill < Formula
  desc "Mobile app UX exploration and competitive change detection CLI"
  homepage "https://github.com/corca-ai/crill"
  version "0.2.1"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/corca-ai/crill/releases/download/v0.2.1/crill_0.2.1_darwin_amd64.tar.gz"
      sha256 "4e079a745ccf86d33822aa3534fc636b8b46a8be7e71a697251b1567e8f9e4bb"

      def install
        bin.install "crill"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/corca-ai/crill/releases/download/v0.2.1/crill_0.2.1_darwin_arm64.tar.gz"
      sha256 "60f7190f8d4d9bf6969e97a897a123f112d6a792c2e42e80c00ab5b3e38122b1"

      def install
        bin.install "crill"
      end
    end
  end

  # Record the install channel so `crill doctor` can report it without
  # guessing. Schema documented in docs/distribution.md and
  # src/crill/install.py. No secrets are written — the file is
  # world-readable.
  def post_install
    manifest_dir = Pathname.new(Dir.home) / ".crill"
    manifest_dir.mkpath
    begin
      manifest_dir.chmod(0o700)
    rescue StandardError
      # best-effort — network mounts may reject the chmod
    end

    manifest = {
      "schema_version" => 1,
      "method" => "homebrew",
      "version" => version.to_s,
      "installed_at" => Time.now.utc.strftime("%Y-%m-%dT%H:%M:%SZ"),
      "binary_path" => (bin/"crill").to_s,
      "gate_url" =>
        ENV["CRILL_GATE_URL"] ||
          "https://crill-gate.health-coach-ted.workers.dev",
    }
    manifest_path = manifest_dir / "install.json"
    manifest_path.write(JSON.pretty_generate(manifest) + "\n")
    manifest_path.chmod(0o644)
    ohai "Recorded install manifest at #{manifest_path}"
  end

  test do
    system bin/"crill", "--version"
  end
end
