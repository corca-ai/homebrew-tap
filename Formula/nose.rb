class Nose < Formula
  desc "Detect semantic (Type-4) code clones and refactoring candidates across many languages"
  homepage "https://github.com/corca-ai/nose"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/corca-ai/nose/releases/download/v0.3.0/nose-cli-aarch64-apple-darwin.tar.xz"
      sha256 "7cb56df8b315e27513871998c48774136c76321ef7b76e1c05c6067e942569dc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/corca-ai/nose/releases/download/v0.3.0/nose-cli-x86_64-apple-darwin.tar.xz"
      sha256 "8914c25ed010a8831490002e5436817733a42bd70ec63d76210d4d6850b663cc"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/corca-ai/nose/releases/download/v0.3.0/nose-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1bb1ce40294da4a04ac45f463eaf9ada7e7d609ec26c71bdcb7153a7be32c478"
    end
    if Hardware::CPU.intel?
      url "https://github.com/corca-ai/nose/releases/download/v0.3.0/nose-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "54c9790d1a88ed4fcf295c934d3801242c1f6d5bd67a48f78c006272a0960b09"
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
