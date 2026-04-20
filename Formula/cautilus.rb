class Cautilus < Formula
  desc "Intentful behavior evaluation toolkit"
  homepage "https://github.com/corca-ai/cautilus"
  url "https://github.com/corca-ai/cautilus/archive/refs/tags/v0.8.0.tar.gz"
  sha256 "e929e57b47ade5ca612de1732a06c0529f1f4dc35ece674a9f4ba7fcd7ac7641"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = "-X github.com/corca-ai/cautilus/internal/cli.buildVersion=v0.8.0"
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/cautilus"
  end

  test do
    assert_match "0.8.0", shell_output("#{bin}/cautilus --version").strip
  end
end
