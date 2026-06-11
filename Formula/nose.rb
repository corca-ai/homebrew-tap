class Nose < Formula
  desc "Detect semantic (Type-4) code clones and refactoring candidates across many languages"
  homepage "https://github.com/corca-ai/nose"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/corca-ai/nose/releases/download/v0.6.0/nose-cli-aarch64-apple-darwin.tar.xz"
      sha256 "5f55a09a2ce468875a2655372adfccf3e84edc34618fb2d1c4f82664ba149f68"
    end
    if Hardware::CPU.intel?
      url "https://github.com/corca-ai/nose/releases/download/v0.6.0/nose-cli-x86_64-apple-darwin.tar.xz"
      sha256 "bb4dfee5c906f4f8953085edb70c6ee5f912ad627ea056403407c01d78a0c174"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/corca-ai/nose/releases/download/v0.6.0/nose-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "80f03fe3a03245c1441e1c7b5cec653b0cbdd0dedfeaf98c21e6c517b57e1cae"
    end
    if Hardware::CPU.intel?
      url "https://github.com/corca-ai/nose/releases/download/v0.6.0/nose-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1bc4d6e6dcf0fdd9c82b75f2e663bc7fbad3ee80cb1669e8fdab8fe4acc2cfa7"
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
