class Cautilus < Formula
  desc "Intentful behavior evaluation toolkit"
  homepage "https://github.com/corca-ai/cautilus"
  url "https://github.com/corca-ai/cautilus/archive/refs/tags/v0.5.2.tar.gz"
  sha256 "abb62cbe356dafb85f9c237d67744cae50d5927576b16fdc84a1bda9da55e6c6"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = "-X github.com/corca-ai/cautilus/internal/cli.buildVersion=v0.5.2"
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/cautilus"
  end

  test do
    assert_match "0.5.2", shell_output("#{bin}/cautilus --version").strip
  end
end
