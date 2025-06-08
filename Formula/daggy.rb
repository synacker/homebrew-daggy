class Daggy < Formula
  desc "Daggy - Data Aggregation Utility"
  homepage "https://daggy.gitbook.io"
  url "https://github.com/synacker/daggy/archive/refs/tags/v2.2.3.tar.gz"
  sha256 "fed4a56d970f37a858a80c2ef1f0fc8d928cd8b1daead166141a538782030864"
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


    system "cmake", "-DVERSION=#{version}.0", "-DBUILD_SHARED_LIBS=ON", "-DCMAKE_INSTALL_RPATH=#{rpath}", "-S", "src", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    assert_match "daggy #{version}", shell_output("#{bin}/daggy -v")
    system "true"
  end
end
