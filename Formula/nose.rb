class Nose < Formula
  desc "Detect semantic (Type-4) code clones and refactoring candidates across many languages"
  homepage "https://github.com/corca-ai/nose"
  version "0.21.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/corca-ai/nose/releases/download/v0.21.0/nose-cli-aarch64-apple-darwin.tar.xz"
      sha256 "f59993ed5157fbb757d992f10b601c966ab004dd52348a6e492310c21cafd891"
    end
    if Hardware::CPU.intel?
      url "https://github.com/corca-ai/nose/releases/download/v0.21.0/nose-cli-x86_64-apple-darwin.tar.xz"
      sha256 "e5cb88d02ef22387d6b7e97e0dd48fadc094ba92f653d5712c4d99c624afd718"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/corca-ai/nose/releases/download/v0.21.0/nose-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "fbda5adc746c9d0e6a3516236892e467227367ccad528fb3af1e3a87713e88e0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/corca-ai/nose/releases/download/v0.21.0/nose-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "49055374c37c4216d55f32ab389ed80f6cbdcf3f07f157d59880f9b005e6f5e6"
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
      bin.install "nose"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "nose"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "nose"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "nose"
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
