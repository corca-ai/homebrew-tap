class Cautilus < Formula
  desc "Intentful behavior evaluation toolkit"
  homepage "https://github.com/corca-ai/cautilus"
  url "https://github.com/corca-ai/cautilus/archive/refs/tags/v0.6.1.tar.gz"
  sha256 "ecdc40f177a2089f5e7b3bba38303ce7326a546882736622e6f35435354bb3ba"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = "-X github.com/corca-ai/cautilus/internal/cli.buildVersion=v0.6.1"
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/cautilus"
  end

  test do
    assert_match "0.6.1", shell_output("#{bin}/cautilus --version").strip
  end
end
