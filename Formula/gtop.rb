require "language/node"

class Gtop < Formula
  desc "System monitoring dashboard for terminal"
  homepage "https://github.com/aksakalli/gtop"
  url "https://registry.npmjs.org/gtop/-/gtop-1.1.3.tgz"
  sha256 "5bd04175c5d075b58448cf4fff3a2c6a760e28807e73f4a8f1ab0adf14d7c926"
  license "MIT"

  # Linux bottle removed for GCC 12 migration
  bottle do
    sha256 cellar: :any_skip_relocation, arm64_monterey: "f7bfefab47efb569bebb4e3c5ee45159c8f26aaf6fda49b74015bdc665be8dcf"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "f7bfefab47efb569bebb4e3c5ee45159c8f26aaf6fda49b74015bdc665be8dcf"
    sha256 cellar: :any_skip_relocation, monterey:       "bd9f489110a6841a2306afef5b77e160e34e650a1fc63978698d54a982358a8b"
    sha256 cellar: :any_skip_relocation, big_sur:        "bd9f489110a6841a2306afef5b77e160e34e650a1fc63978698d54a982358a8b"
    sha256 cellar: :any_skip_relocation, catalina:       "bd9f489110a6841a2306afef5b77e160e34e650a1fc63978698d54a982358a8b"
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    assert_match "Error: Width must be multiple of 2", shell_output(bin/"gtop 2>&1", 1)
  end
end
