class Cautilus < Formula
  desc "Intentful behavior evaluation toolkit"
  homepage "https://github.com/corca-ai/cautilus"
  url "https://github.com/corca-ai/cautilus/archive/refs/tags/v0.7.1.tar.gz"
  sha256 "0f20be76734cfaf348f36f7f90701e99bc9860b996c044c3c4b0e0506bc3e0d7"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = "-X github.com/corca-ai/cautilus/internal/cli.buildVersion=v0.7.1"
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/cautilus"
  end

  test do
    assert_match "0.7.1", shell_output("#{bin}/cautilus --version").strip
  end
end
