class Cautilus < Formula
  desc "Intentful behavior evaluation toolkit"
  homepage "https://github.com/corca-ai/cautilus"
  url "https://github.com/corca-ai/cautilus/archive/refs/tags/v0.5.1.tar.gz"
  sha256 "29fc7ebaf1b9e04e844d8751ce8a8e92ed8a53fb3b7bbb00b331d8b10d9435ef"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = "-X github.com/corca-ai/cautilus/internal/cli.buildVersion=v0.5.1"
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/cautilus"
  end

  test do
    assert_match "0.5.1", shell_output("#{bin}/cautilus --version").strip
  end
end
