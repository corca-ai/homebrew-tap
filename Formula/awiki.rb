class Awiki < Formula
  desc "CLI for exploring and maintaining flat-file Markdown wikis"
  homepage "https://github.com/corca-ai/awiki"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/corca-ai/awiki/releases/download/v0.5.0/awiki-aarch64-apple-darwin.tar.xz"
      sha256 "8d2ad4bbb49c390ada2b2a1c882c4fd42475d1d242ee8d2f29ed47c33e7d6fa7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/corca-ai/awiki/releases/download/v0.5.0/awiki-x86_64-apple-darwin.tar.xz"
      sha256 "0e3f4a07291d6691667a07f79c889cf675178c5a01bd2bbc6fde3de9cf1e3a86"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/corca-ai/awiki/releases/download/v0.5.0/awiki-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "bace1519f8afafb4172a28dc193d702390cab2f3263a2dc7d0b70cfcd63cc521"
    end
    if Hardware::CPU.intel?
      url "https://github.com/corca-ai/awiki/releases/download/v0.5.0/awiki-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c0b7ee22c089130c5ace0cd7201cf8c39a48afbfbc220463b03f5ba41fe8200e"
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
    bin.install "awiki" if OS.mac? && Hardware::CPU.arm?
    bin.install "awiki" if OS.mac? && Hardware::CPU.intel?
    bin.install "awiki" if OS.linux? && Hardware::CPU.arm?
    bin.install "awiki" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
