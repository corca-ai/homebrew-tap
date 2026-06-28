class Awiki < Formula
  desc "CLI for exploring and maintaining flat-file Markdown wikis"
  homepage "https://github.com/corca-ai/awiki"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/corca-ai/awiki/releases/download/v0.3.0/awiki-aarch64-apple-darwin.tar.xz"
      sha256 "ecaabb14926a16ee104ebc7852af13e99a60a1d831d2f1e2f8f296c3bb4842ea"
    end
    if Hardware::CPU.intel?
      url "https://github.com/corca-ai/awiki/releases/download/v0.3.0/awiki-x86_64-apple-darwin.tar.xz"
      sha256 "d6b0ec5028ed64d8f47269c6ec8068fcdf2283dc125ee0c431b14e14ca1cf90a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/corca-ai/awiki/releases/download/v0.3.0/awiki-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "32c87bad0eff33e3c10f9b0dc86a792b9a485933f29f990aaba34f1c3203e621"
    end
    if Hardware::CPU.intel?
      url "https://github.com/corca-ai/awiki/releases/download/v0.3.0/awiki-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5679716f77b96038be8b7dc91606bb965e709966b9ba25c51ec24bb7cdd87185"
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
