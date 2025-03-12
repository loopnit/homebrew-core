class Krep < Formula
  desc "High-Performance String Search Utility"
  homepage "https://davidesantangelo.github.io/krep/"
  url "https://github.com/davidesantangelo/krep/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "6b8bf0f3c9e6e94e428fd00a3bf8dc9e85bdd834e8e8a163c932506625622090"
  license "BSD-2-Clause"

  depends_on "make" => :build

  def install
    system "make"
    bin.install "krep"
  end

  test do
    text_file = testpath/"file.txt"
    text_file.write "This should result in one match"

    output = shell_output("#{bin}/krep -c 'match' #{text_file}")
    assert_match "Found 1 matches", output

    assert_match "krep v#{version}", shell_output("#{bin}/krep -v")
  end
end
