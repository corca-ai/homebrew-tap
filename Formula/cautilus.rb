class Cautilus < Formula
  desc "Intentful behavior evaluation toolkit"
  homepage "https://github.com/corca-ai/cautilus"
  url "https://github.com/corca-ai/cautilus/archive/refs/tags/v0.10.0.tar.gz"
  sha256 "fe66b871f5799d32dcb8b68eeff63e2a3332b3f23e083cccf55f5b17bfb388ae"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = "-X github.com/corca-ai/cautilus/internal/cli.buildVersion=v0.10.0"
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/cautilus"
  end

  test do
    assert_match "0.10.0", shell_output("#{bin}/cautilus --version").strip
  end
end
