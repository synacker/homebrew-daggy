class DaggyAT220 < Formula
  desc "Daggy - Data Aggregation Utility"
  homepage "https://daggy.gitbook.io"
  url "https://github.com/synacker/daggy/archive/refs/tags/v2.2.0.tar.gz"
  sha256 "5f813c1619167d3bd981c811ee0afca4b59140a659b41602737fdfb7b66e182e"
  license "MIT"

  depends_on "cmake" => :build
  depends_on "libssh2"
  depends_on "qt"
  depends_on "yaml-cpp"

  resource "mustache" do
    url "https://github.com/kainjow/Mustache/blob/04277d5552c6e46bee41a946b7d175a660ea1b3d/mustache.hpp"
    sha256 "63222e3cce951ec557245de4186886640076fb2ddfab621ee4ab88708c12a014"
  end

  def install
    resource("mustache").stage { cp_r "mustache.hpp", "src" }

    system "cmake", "-D", "VERSION=#{version}", "-D", "BUILD_SHARED_LIBS=ON", "-S", "src", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    assert_match "daggy #{version}", shell_output("#{bin}/daggy -v")
    system "false"
  end
end
