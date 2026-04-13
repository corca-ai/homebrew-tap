class Cautilus < Formula
  desc "Intentful behavior evaluation toolkit"
  homepage "https://github.com/corca-ai/cautilus"
  url "https://github.com/corca-ai/cautilus/archive/refs/tags/v0.2.3.tar.gz"
  sha256 "771e8aa41f406b17a0a5f6150d31ebd4320d7da2a1c75c2e44a27bf33e8e7d8c"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = "-X github.com/corca-ai/cautilus/internal/cli.buildVersion=v0.2.3"
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/cautilus"
  end

  test do
    assert_match "0.2.3", shell_output("#{bin}/cautilus --version").strip
  end
end
