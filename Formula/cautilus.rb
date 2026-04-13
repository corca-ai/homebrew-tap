class Cautilus < Formula
  desc "Intentful behavior evaluation toolkit"
  homepage "https://github.com/corca-ai/cautilus"
  url "https://github.com/corca-ai/cautilus/archive/refs/tags/v0.2.2.tar.gz"
  sha256 "6794b204e9c4c7a2a92a62281de9f7a64521959350f6bba6756cd858e7503174"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = "-X github.com/corca-ai/cautilus/internal/cli.buildVersion=v0.2.2"
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/cautilus"
  end

  test do
    assert_match "0.2.2", shell_output("#{bin}/cautilus --version").strip
  end
end
