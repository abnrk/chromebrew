require 'package'

class Libotf < Package
  description 'OpenType Font library'
  homepage 'https://www.nongnu.org/m17n/'
  version '0.9.16'
  license 'LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://download.savannah.gnu.org/releases/m17n/libotf-#{version}.tar.gz"
  source_sha256 '68db0ca3cda2d46a663a92ec26e6eb5adc392ea5191bcda74268f0aefa78066b'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '48ea420876299f2de783c250b6def3c2a87e7bf8c16695a63b7561efbb9594f8',
     armv7l: '48ea420876299f2de783c250b6def3c2a87e7bf8c16695a63b7561efbb9594f8',
     x86_64: '8ec1c9f4e8b99482323e3bf444cca95b5e3d0abb90b8ea278d1461b29470e340'
  })

  depends_on 'libxaw'
  depends_on 'freetype'
  depends_on 'hashpipe'

  def self.patch
    system 'curl -Ls https://github.com/archlinux/svntogit-packages/raw/a67b940a19f1e7e47e7d8553ed31158ed70f1286/libotf/trunk/replace-freetype-config.patch | hashpipe sha256 edd0f86332f4d809dfb0ab66da547c946e5d79a907a7eaddc4d2166c78205668 | patch -p1 -b'
  end

  def self.build
    system 'autoreconf -i'
    system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      ./configure #{CREW_CONFIGURE_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
