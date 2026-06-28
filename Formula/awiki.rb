class Awiki < Formula
  desc "CLI for exploring and maintaining flat-file Markdown wikis"
  homepage "https://github.com/corca-ai/awiki"
  version "0.4.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/corca-ai/awiki/releases/download/v0.4.1/awiki-aarch64-apple-darwin.tar.xz"
      sha256 "40ecc0a691b4c2d4ef1c5e219b94ea842abf666972d042742ab7dd402672649e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/corca-ai/awiki/releases/download/v0.4.1/awiki-x86_64-apple-darwin.tar.xz"
      sha256 "b282272c92891996b8fcf7f1d475aa5f74dbc946de7b81377d0569812af324c6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/corca-ai/awiki/releases/download/v0.4.1/awiki-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "92c9de1b545d63f918ee807979725264cc35bdf1c699f5ceff7ed1e8dcabb351"
    end
    if Hardware::CPU.intel?
      url "https://github.com/corca-ai/awiki/releases/download/v0.4.1/awiki-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4edeab90276918dd2143aca942a9d87789e029b5a19c0d35d51338ad3f25d4a1"
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
