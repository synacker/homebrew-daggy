class Daggy < Formula
  desc "Daggy - Data Aggregation Utility and C/C++ developer library for data streams catching"
  homepage "https://daggy.dev"
  url "https://github.com/synacker/daggy/archive/refs/tags/v2.1.3.zip"
  sha256 "20dd0abe711e5435c3818026b4356392341cf91d217c37a0d7ee2ab7d112763e"
  license "MIT"

  depends_on "cmake" => :build
  depends_on "wget" => :build
  depends_on "qt"
  depends_on "yaml-cpp"
  depends_on "libssh2"

  def install
    system "wget", "https://raw.githubusercontent.com/kainjow/Mustache/master/mustache.hpp", "-O", "src/mustache.hpp"
    system "mkdir", "build"
    
    Dir.chdir('build')
    system "cmake", "-D", "VERSION=2.1.3", "-D", "CMAKE_INSTALL_PREFIX:PATH=#{prefix}", "-D", "CMAKE_BUILD_TYPE=Release", "-D", "BUILD_SHARED_LIBS=ON", "../src"
    system "make", "all"
    system "make", "install"
  end

  test do
    assert_match "daggy 2.1.3", shell_output("#{bin}/daggy -v")
  end
end