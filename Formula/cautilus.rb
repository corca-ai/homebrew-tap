class Cautilus < Formula
  desc "Intentful behavior evaluation toolkit"
  homepage "https://github.com/corca-ai/cautilus"
  url "https://github.com/corca-ai/cautilus/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "ecdd1c0c92080955d209364eb2ef01f374a760da395067ab8a5bb60f786eb8b5"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = "-X github.com/corca-ai/cautilus/internal/cli.buildVersion=v0.4.0"
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/cautilus"
  end

  test do
    assert_match "0.4.0", shell_output("#{bin}/cautilus --version").strip
  end
end
