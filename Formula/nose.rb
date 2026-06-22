class Nose < Formula
  desc "Detect semantic (Type-4) code clones and refactoring candidates across many languages"
  homepage "https://github.com/corca-ai/nose"
  version "0.15.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/corca-ai/nose/releases/download/v0.15.0/nose-cli-aarch64-apple-darwin.tar.xz"
      sha256 "35dc80b3f693735d664e71924c2d616b1bd8b6dc461b08a74b0c0385f25e15ad"
    end
    if Hardware::CPU.intel?
      url "https://github.com/corca-ai/nose/releases/download/v0.15.0/nose-cli-x86_64-apple-darwin.tar.xz"
      sha256 "e88d13a930c407dc35515330ae2243d9935204f2f1b31305dbf6414029b7e08a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/corca-ai/nose/releases/download/v0.15.0/nose-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4f8bc813ed330e3f916b2b2f94081398f5a6e0b10c271a34e568e4eca3b96934"
    end
    if Hardware::CPU.intel?
      url "https://github.com/corca-ai/nose/releases/download/v0.15.0/nose-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c640a9385563d67cbf17406267c5a5a75b33b57abf72649275b9ee8d5d8d2264"
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
