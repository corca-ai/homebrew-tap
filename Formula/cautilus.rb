class Cautilus < Formula
  desc "Intentful behavior evaluation toolkit"
  homepage "https://github.com/corca-ai/cautilus"
  url "https://github.com/corca-ai/cautilus/archive/refs/tags/v0.7.0.tar.gz"
  sha256 "1833ceacf4917b932348cb3ca7f7aadc997e13d0cb34796a3d40d0876a7e3ec0"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = "-X github.com/corca-ai/cautilus/internal/cli.buildVersion=v0.7.0"
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/cautilus"
  end

  test do
    assert_match "0.7.0", shell_output("#{bin}/cautilus --version").strip
  end
end
