class Nose < Formula
  desc "Detect semantic (Type-4) code clones and refactoring candidates across many languages"
  homepage "https://github.com/corca-ai/nose"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/corca-ai/nose/releases/download/v0.1.1/nose-cli-aarch64-apple-darwin.tar.xz"
      sha256 "4be10e0efab7fecce7f09dbd3e4f3bdfb5665d76ae8b952326ae32ceea015913"
    end
    if Hardware::CPU.intel?
      url "https://github.com/corca-ai/nose/releases/download/v0.1.1/nose-cli-x86_64-apple-darwin.tar.xz"
      sha256 "660640a954f1c296d8c9f5e432b25abb0296bc37643bf446b394cbf6d6b41037"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/corca-ai/nose/releases/download/v0.1.1/nose-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3fd16b54f966da60044bb428b2d87ab78cd4acafc5548e22a36cfeff0a4a7f97"
    end
    if Hardware::CPU.intel?
      url "https://github.com/corca-ai/nose/releases/download/v0.1.1/nose-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "54a477bec2245cc0e4086d569714d86fc7a291edaf1ca4d08c32ec0845a6dcf3"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "nose" if OS.mac? && Hardware::CPU.arm?
    bin.install "nose" if OS.mac? && Hardware::CPU.intel?
    bin.install "nose" if OS.linux? && Hardware::CPU.arm?
    bin.install "nose" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
