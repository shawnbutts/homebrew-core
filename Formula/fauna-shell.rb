require "language/node"

class FaunaShell < Formula
  desc "Interactive shell for FaunaDB"
  homepage "https://fauna.com/"
  url "https://registry.npmjs.org/fauna-shell/-/fauna-shell-0.15.0.tgz"
  sha256 "ac7339ae28b4815958e19079221c18af0704825243b6cbdd23c5e1120df955c6"
  license "MPL-2.0"

  # Linux bottle removed for GCC 12 migration
  bottle do
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d33aaad33a615822bba12c72a579c4864e07e6445909495c2e80221440055b7e"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "d33aaad33a615822bba12c72a579c4864e07e6445909495c2e80221440055b7e"
    sha256 cellar: :any_skip_relocation, monterey:       "21eb180f13feb537c213825d3882642e0ede1ab87b3940fc278fc693569adf2e"
    sha256 cellar: :any_skip_relocation, big_sur:        "21eb180f13feb537c213825d3882642e0ede1ab87b3940fc278fc693569adf2e"
    sha256 cellar: :any_skip_relocation, catalina:       "21eb180f13feb537c213825d3882642e0ede1ab87b3940fc278fc693569adf2e"
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    output = shell_output("#{bin}/fauna list-endpoints 2>&1", 1)
    assert_match "No endpoints defined", output

    # FIXME: This test seems to stall indefinitely on Linux.
    # https://github.com/jdxcode/password-prompt/issues/12
    return if OS.linux? && ENV["HOMEBREW_GITHUB_ACTIONS"].present?

    pipe_output("#{bin}/fauna add-endpoint https://db.fauna.com:443", "your_fauna_secret\nfauna_endpoint\n")

    output = shell_output("#{bin}/fauna list-endpoints")
    assert_match "fauna_endpoint *\n", output
  end
end
