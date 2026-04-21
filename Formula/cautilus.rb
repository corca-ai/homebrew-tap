class Cautilus < Formula
  desc "Intentful behavior evaluation toolkit"
  homepage "https://github.com/corca-ai/cautilus"
  url "https://github.com/corca-ai/cautilus/archive/refs/tags/v0.9.0.tar.gz"
  sha256 "86f366e3ecf4952b01fed668f243e448ac5bb03dd14078cd3a279beee0144206"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = "-X github.com/corca-ai/cautilus/internal/cli.buildVersion=v0.9.0"
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/cautilus"
  end

  test do
    assert_match "0.9.0", shell_output("#{bin}/cautilus --version").strip
  end
end
