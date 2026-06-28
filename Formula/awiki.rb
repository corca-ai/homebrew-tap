class Awiki < Formula
  desc "CLI for exploring and maintaining flat-file Markdown wikis"
  homepage "https://github.com/corca-ai/awiki"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/corca-ai/awiki/releases/download/v0.4.0/awiki-aarch64-apple-darwin.tar.xz"
      sha256 "ebc29ef0fba5232b6ffc03133fe4ddfdfa08ba7d3bcec4de8670ac28cef1ec74"
    end
    if Hardware::CPU.intel?
      url "https://github.com/corca-ai/awiki/releases/download/v0.4.0/awiki-x86_64-apple-darwin.tar.xz"
      sha256 "6f6b9c4ffa16c824ef4d1213ae3e291b90df2010148e7058efba5cdba529eda9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/corca-ai/awiki/releases/download/v0.4.0/awiki-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "497d4c9b4d8be499995f89030210386f4f5f338f1c3c4fee8ce15671aed1c21f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/corca-ai/awiki/releases/download/v0.4.0/awiki-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c168c9c494c40aee30d5712c8dd77b0e8c2a4abcea1a6abc23d06fda7a48df05"
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
