class Awiki < Formula
  desc "CLI for exploring and maintaining flat-file Markdown wikis"
  homepage "https://github.com/corca-ai/awiki"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/corca-ai/awiki/releases/download/v0.6.0/awiki-aarch64-apple-darwin.tar.xz"
      sha256 "78f299201922c191f56068edea80dedddb340d5d93a6d367e84d6d8192d35baf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/corca-ai/awiki/releases/download/v0.6.0/awiki-x86_64-apple-darwin.tar.xz"
      sha256 "84f7bc216c84dc84595534829d7dd37ed5f4a17f90b086eabb9581f068747222"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/corca-ai/awiki/releases/download/v0.6.0/awiki-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c29effc9567ffa2da1829136710276c314371fc25ec907e38ef0247866fb93d8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/corca-ai/awiki/releases/download/v0.6.0/awiki-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c6e911ede51e895e75e9e1cc93d9e69b07188008edf883409dd210a36aa99f27"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "awiki"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "awiki"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "awiki"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "awiki"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
