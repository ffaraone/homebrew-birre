class TailK < Formula
  include Language::Python::Virtualenv

  desc "TailK is a small utility to tail logs from multiple kubernetes pods."
  homepage "https://github.com/ffaraone/tailk"
  url "https://files.pythonhosted.org/packages/37/71/0aca16f07c41b90a4211ad52b46e4406f05d128ff20b3006b1e3a87bd1fc/tailk-0.1.0.tar.gz"
  sha256 "51bef4417220ab6f31308589a1d237b59e13d144b571bacab9e419f309c7e1cf"
  license "Apache-2.0"
  version "0.1.0"
  head "https://github.com/ffaraone/tailk.git"


  depends_on "python@3.10"

  def install
    venv = virtualenv_create(libexec, "python3")

    system libexec/"bin/pip", "install", "-v", "--no-deps",
                              "--ignore-installed", "click==8.1.3"
    system libexec/"bin/pip", "install", "-v", "--no-deps",
                              "--ignore-installed", "markdown-it-py==2.1.0"
    system libexec/"bin/pip", "install", "-v", "--no-deps",
                              "--ignore-installed", "mdurl==0.1.2"
    system libexec/"bin/pip", "install", "-v", "--no-deps",
                              "--ignore-installed", "Pygments==2.14.0"
    system libexec/"bin/pip", "install", "-v", "--no-deps",
                              "--ignore-installed", "rich==13.3.1"
    system libexec/"bin/pip", "install", "-v", "--no-deps",
                              "--ignore-installed", "uvloop==0.17.0"
    system libexec/"bin/pip", "install", "-v", "--no-deps",
                              "--ignore-installed", "--no-binary",
                              ":all", buildpath
    bin.install_symlink libexec/"bin/tailk"
  end

  test do
    assert_include "TailK", shell_output("#{bin}/tailk --help").strip
  end
end