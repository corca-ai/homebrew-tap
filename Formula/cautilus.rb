class Cautilus < Formula
  desc "Intentful behavior evaluation toolkit"
  homepage "https://github.com/corca-ai/cautilus"
  url "https://github.com/corca-ai/cautilus/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "d54b1bba78ca2043c4e2859ce676338cb53fcb02de57c9aad366a4477c75e47a"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = "-X github.com/corca-ai/cautilus/internal/cli.buildVersion=v0.3.1"
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/cautilus"
  end

  test do
    assert_match "0.3.1", shell_output("#{bin}/cautilus --version").strip
  end
end
