class Daggy < Formula
  desc "Daggy - Data Aggregation Utility and C/C++ developer library for data streams catching"
  homepage "https://daggy.dev"
  url "https://github.com/synacker/daggy/archive/refs/tags/2.1.2.zip"
  sha256 "115249d58a4282ce112fa9efda7bd4b5630783440abb45f28b671a4fee017055"
  license "MIT"

  depends_on "cmake" => :build
  depends_on "wget" => :build
  depends_on "qt"
  depends_on "yaml-cpp"
  depends_on "libssh2"

  patch do
    url "https://raw.githubusercontent.com/synacker/daggy_homebrew/master/mustache.patch"
    sha256 "8ccee97c0e38c385b934e079371da42de8d2997488186f82969e1965b8b86ddc"
  end

  def install
    system "wget", "https://raw.githubusercontent.com/kainjow/Mustache/master/mustache.hpp", "-O", "src/Daggy/mustache.hpp"
    system "mkdir", "build"
    Dir.chdir('build')
    system "cmake", "-D", "VERSION=2.1.2", "-D", "CMAKE_INSTALL_PREFIX:PATH=#{prefix}", "-D", "CMAKE_BUILD_TYPE=Release", "../src"
    system "make", "all"
    system "make", "install"
  end

  test do
    assert_match "daggy 2.1.2", shell_output("#{bin}/daggy -v")
  end
end