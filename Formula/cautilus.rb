class Cautilus < Formula
  desc "Intentful behavior evaluation toolkit"
  homepage "https://github.com/corca-ai/cautilus"
  url "https://github.com/corca-ai/cautilus/archive/refs/tags/v0.5.3.tar.gz"
  sha256 "07c882257e3e3f64a7744261ffb8da27103a37333c223c3fb3cd5a618ef980d3"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = "-X github.com/corca-ai/cautilus/internal/cli.buildVersion=v0.5.3"
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/cautilus"
  end

  test do
    assert_match "0.5.3", shell_output("#{bin}/cautilus --version").strip
  end
end
