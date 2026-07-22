class Nose < Formula
  desc "Detect semantic (Type-4) code clones and refactoring candidates across many languages"
  homepage "https://github.com/corca-ai/nose"
  version "0.20.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/corca-ai/nose/releases/download/v0.20.0/nose-cli-aarch64-apple-darwin.tar.xz"
      sha256 "c737cb0e571f1a9b91020d7610443b8d3c885a552f690375315d1ce29330e6a5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/corca-ai/nose/releases/download/v0.20.0/nose-cli-x86_64-apple-darwin.tar.xz"
      sha256 "a2fd52a09dcfdb1ae84cada859d4b5a824af8e8dd93a37809ff1c61336134505"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/corca-ai/nose/releases/download/v0.20.0/nose-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d98f95398655bdcadfd849c71088361358058b660d7f702b5ac8bd12db205454"
    end
    if Hardware::CPU.intel?
      url "https://github.com/corca-ai/nose/releases/download/v0.20.0/nose-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ae28f5fdd845570c1e9d4d2b2149d25c80952bea0a5ddbe9396b28880c1f4717"
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
