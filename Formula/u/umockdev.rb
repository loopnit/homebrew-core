class Umockdev < Formula
  desc "Mock hardware devices for creating unit tests and bug reporting"
  homepage "https://github.com/martinpitt/umockdev"
  url "https://github.com/martinpitt/umockdev/releases/download/0.19.1/umockdev-0.19.1.tar.xz"
  sha256 "2cece0e8e366b89b4070be74f3389c9f7fa21aca56d8a5357e96e30cd8d4f426"
  license "LGPL-2.1-or-later"
  head "https://github.com/martinpitt/umockdev.git", branch: "main"

  depends_on "gobject-introspection" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => [:build, :test]
  depends_on "vala" => :build

  depends_on "glib"
  depends_on "libpcap"
  depends_on :linux
  depends_on "systemd"

  def install
    system "meson", "setup", "build", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
    pkgshare.install "docs/examples"
  end

  test do
    flags = shell_output("pkgconf --cflags --libs umockdev-1.0 gio-2.0").chomp.split
    system ENV.cc, pkgshare/"examples/battery.c", "-o", "battery", *flags
    system bin/"umockdev-wrapper", "./battery"
  end
end
