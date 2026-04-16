class Cautilus < Formula
  desc "Intentful behavior evaluation toolkit"
  homepage "https://github.com/corca-ai/cautilus"
  url "https://github.com/corca-ai/cautilus/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "8a1fbdf212a08382b35e82dfd85569b0cc312a1303357795d515b100a7c1ff28"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = "-X github.com/corca-ai/cautilus/internal/cli.buildVersion=v0.5.0"
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/cautilus"
  end

  test do
    assert_match "0.5.0", shell_output("#{bin}/cautilus --version").strip
  end
end
