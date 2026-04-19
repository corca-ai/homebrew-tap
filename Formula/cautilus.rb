class Cautilus < Formula
  desc "Intentful behavior evaluation toolkit"
  homepage "https://github.com/corca-ai/cautilus"
  url "https://github.com/corca-ai/cautilus/archive/refs/tags/v0.5.7.tar.gz"
  sha256 "91ed51dcfce8f5022f9d7392d0f0b3592afdbdcafa9debcd2f02c07f015fdb32"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = "-X github.com/corca-ai/cautilus/internal/cli.buildVersion=v0.5.7"
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/cautilus"
  end

  test do
    assert_match "0.5.7", shell_output("#{bin}/cautilus --version").strip
  end
end
