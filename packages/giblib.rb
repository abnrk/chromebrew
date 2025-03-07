require 'package'

class Giblib < Package
  description 'giblib is a simple library which wraps imlib2.'
  homepage 'http://freshmeat.sourceforge.net/projects/giblib/'
  version '1.2.4'
  license 'feh'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://deb.debian.org/debian/pool/main/g/giblib/giblib_1.2.4.orig.tar.gz'
  source_sha256 'e437756ce3ded019946fb3d979991cda7604bc345dbb1338b17655caff65a3d3'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'cd6fb66f5d4c31c8bd10016bd1aa3d520989527b8f9415a7feb3e3f517781db2',
     armv7l: 'cd6fb66f5d4c31c8bd10016bd1aa3d520989527b8f9415a7feb3e3f517781db2',
     x86_64: '6e2fbfb1686cc25d21d36e0d62ca61333d923a1d528d21d870241de4428d6ceb'
  })

  depends_on 'imlib2'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
