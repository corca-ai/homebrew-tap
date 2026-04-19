class Cautilus < Formula
  desc "Intentful behavior evaluation toolkit"
  homepage "https://github.com/corca-ai/cautilus"
  url "https://github.com/corca-ai/cautilus/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "0dab77e6218c1bca5864e93c05720acc27f0cffda47b00e98de62c48cfc2d75a"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = "-X github.com/corca-ai/cautilus/internal/cli.buildVersion=v0.6.0"
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/cautilus"
  end

  test do
    assert_match "0.6.0", shell_output("#{bin}/cautilus --version").strip
  end
end
