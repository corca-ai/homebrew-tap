class Cautilus < Formula
  desc "Intentful behavior evaluation toolkit"
  homepage "https://github.com/corca-ai/cautilus"
  url "https://github.com/corca-ai/cautilus/archive/refs/tags/v0.5.4.tar.gz"
  sha256 "f18d37c91594d98439d4002ff301cf1f3f92ebc397343475dad25f5a40151edc"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = "-X github.com/corca-ai/cautilus/internal/cli.buildVersion=v0.5.4"
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/cautilus"
  end

  test do
    assert_match "0.5.4", shell_output("#{bin}/cautilus --version").strip
  end
end
