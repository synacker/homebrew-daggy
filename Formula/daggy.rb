class Daggy < Formula
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
    url "https://github.com/kainjow/Mustache/archive/refs/tags/v4.1.tar.gz"
    sha256 "acd66359feb4318b421f9574cfc5a511133a77d916d0b13c7caa3783c0bfe167"
  end

  def install
    resource("mustache").stage { cp_r "mustache.hpp", buildpath/"src/mustache.hpp" }

    system "cmake", "-D", "VERSION=#{version}.0", "-D", "BUILD_SHARED_LIBS=ON", "-S", "src", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    assert_match "daggy #{version}", shell_output("#{bin}/daggy -v")
    system "true"
  end
end
