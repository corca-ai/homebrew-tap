class Cautilus < Formula
  desc "Intentful behavior evaluation toolkit"
  homepage "https://github.com/corca-ai/cautilus"
  url "https://github.com/corca-ai/cautilus/archive/refs/tags/v0.2.4.tar.gz"
  sha256 "9aa9acdfed302bc071770847794641b230723fc4a90c43dbd1412f3a73624ecf"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = "-X github.com/corca-ai/cautilus/internal/cli.buildVersion=v0.2.4"
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/cautilus"
  end

  test do
    assert_match "0.2.4", shell_output("#{bin}/cautilus --version").strip
  end
end
