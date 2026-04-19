class Cautilus < Formula
  desc "Intentful behavior evaluation toolkit"
  homepage "https://github.com/corca-ai/cautilus"
  url "https://github.com/corca-ai/cautilus/archive/refs/tags/v0.6.2.tar.gz"
  sha256 "c8b43440e2c86e31f530fafc7ea5f19e08bfbf01813a86de2789320beb2f6f56"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = "-X github.com/corca-ai/cautilus/internal/cli.buildVersion=v0.6.2"
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/cautilus"
  end

  test do
    assert_match "0.6.2", shell_output("#{bin}/cautilus --version").strip
  end
end
