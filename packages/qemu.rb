require 'package'

class Qemu < Package
  description 'QEMU is a generic and open source machine emulator and virtualizer.'
  homepage 'https://www.qemu.org/'
  version '9.2.0'
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  min_glibc '2.29' # Needed for MAP_FIXED_NOREPLACE support.
  source_url 'https://github.com/qemu/qemu.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b07e876cca85b8003be705aee939d5676e0a8109fa69bfb3d7a3cb16d986e67d',
     armv7l: 'b07e876cca85b8003be705aee939d5676e0a8109fa69bfb3d7a3cb16d986e67d',
     x86_64: '30183ad202272d2d568a6da30a58ad228cd1b42daebee015051703cbdd88eafe'
  })

  depends_on 'alsa_lib' # R
  depends_on 'at_spi2_core' # R
  depends_on 'bzip2' # R
  depends_on 'cairo' # R
  depends_on 'curl' # R
  depends_on 'elfutils' # R
  depends_on 'eudev' # R
  depends_on 'fontconfig' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gnutls' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'hicolor_icon_theme'
  depends_on 'jack' # R
  depends_on 'jemalloc'
  depends_on 'libaio' # R
  depends_on 'libcap_ng' # R
  depends_on 'libcyrussasl' # R
  depends_on 'libepoxy' # R
  depends_on 'libgcrypt'
  depends_on 'libjpeg_turbo' # R
  depends_on 'libpng' # R
  depends_on 'libsdl2' # R
  depends_on 'libseccomp' # R
  depends_on 'libslirp' # R
  depends_on 'libssh' # R
  depends_on 'libusb' # R
  depends_on 'libx11' # R
  depends_on 'libxkbcommon' # R
  depends_on 'linux_pam' # R
  depends_on 'lzfse' # R
  depends_on 'lzo' # R
  depends_on 'mesa' # R
  depends_on 'ncurses' # R
  depends_on 'pango' # R
  depends_on 'pipewire' # R
  depends_on 'pixman' # R
  depends_on 'pulseaudio' # R
  depends_on 'py3_sphinx_rtd_theme' => :build
  depends_on 'sdl2_image' # R
  depends_on 'snappy' # R
  depends_on 'sphinx' => :build
  depends_on 'vte' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  def self.patch
    # https://gitlab.com/qemu-project/qemu/-/issues/2718
    File.write 'qemu_patch', <<~QEMU_EOF
      diff --git a/hw/intc/arm_gicv3_its.c b/hw/intc/arm_gicv3_its.c
      index bf31158470e..752322a3e7e 100644
      --- a/hw/intc/arm_gicv3_its.c
      +++ b/hw/intc/arm_gicv3_its.c
      @@ -465,7 +465,7 @@ static ItsCmdResult lookup_vte(GICv3ITSState *s, const =
      char *who,
       static ItsCmdResult process_its_cmd_phys(GICv3ITSState *s, const ITEntry *=
      ite,
                                                int irqlevel)
       {
      -    CTEntry cte;
      +    CTEntry cte =3D {};
           ItsCmdResult cmdres;
      =20
           cmdres =3D lookup_cte(s, __func__, ite->icid, &cte);
      @@ -479,7 +479,7 @@ static ItsCmdResult process_its_cmd_phys(GICv3ITSState =
      *s, const ITEntry *ite,
       static ItsCmdResult process_its_cmd_virt(GICv3ITSState *s, const ITEntry *=
      ite,
                                                int irqlevel)
       {
      -    VTEntry vte;
      +    VTEntry vte =3D {};
           ItsCmdResult cmdres;
      =20
           cmdres =3D lookup_vte(s, __func__, ite->vpeid, &vte);
      @@ -514,8 +514,8 @@ static ItsCmdResult process_its_cmd_virt(GICv3ITSState =
      *s, const ITEntry *ite,
       static ItsCmdResult do_process_its_cmd(GICv3ITSState *s, uint32_t devid,
                                              uint32_t eventid, ItsCmdType cmd)
       {
      -    DTEntry dte;
      -    ITEntry ite;
      +    DTEntry dte =3D {};
      +    ITEntry ite =3D {};
           ItsCmdResult cmdres;
           int irqlevel;
      =20
      @@ -583,8 +583,8 @@ static ItsCmdResult process_mapti(GICv3ITSState *s, con=
      st uint64_t *cmdpkt,
           uint32_t pIntid =3D 0;
           uint64_t num_eventids;
           uint16_t icid =3D 0;
      -    DTEntry dte;
      -    ITEntry ite;
      +    DTEntry dte =3D {};
      +    ITEntry ite =3D {};
      =20
           devid =3D (cmdpkt[0] & DEVID_MASK) >> DEVID_SHIFT;
           eventid =3D cmdpkt[1] & EVENTID_MASK;
      @@ -651,8 +651,8 @@ static ItsCmdResult process_vmapti(GICv3ITSState *s, co=
      nst uint64_t *cmdpkt,
       {
           uint32_t devid, eventid, vintid, doorbell, vpeid;
           uint32_t num_eventids;
      -    DTEntry dte;
      -    ITEntry ite;
      +    DTEntry dte =3D {};
      +    ITEntry ite =3D {};
      =20
           if (!its_feature_virtual(s)) {
               return CMD_CONTINUE;
      @@ -761,7 +761,7 @@ static bool update_cte(GICv3ITSState *s, uint16_t icid,=
       const CTEntry *cte)
       static ItsCmdResult process_mapc(GICv3ITSState *s, const uint64_t *cmdpkt)
       {
           uint16_t icid;
      -    CTEntry cte;
      +    CTEntry cte =3D {};
      =20
           icid =3D cmdpkt[2] & ICID_MASK;
           cte.valid =3D cmdpkt[2] & CMD_FIELD_VALID_MASK;
      @@ -822,7 +822,7 @@ static bool update_dte(GICv3ITSState *s, uint32_t devid=
      , const DTEntry *dte)
       static ItsCmdResult process_mapd(GICv3ITSState *s, const uint64_t *cmdpkt)
       {
           uint32_t devid;
      -    DTEntry dte;
      +    DTEntry dte =3D {};
      =20
           devid =3D (cmdpkt[0] & DEVID_MASK) >> DEVID_SHIFT;
           dte.size =3D cmdpkt[1] & SIZE_MASK;
      @@ -886,9 +886,9 @@ static ItsCmdResult process_movi(GICv3ITSState *s, cons=
      t uint64_t *cmdpkt)
       {
           uint32_t devid, eventid;
           uint16_t new_icid;
      -    DTEntry dte;
      -    CTEntry old_cte, new_cte;
      -    ITEntry old_ite;
      +    DTEntry dte =3D {};
      +    CTEntry old_cte =3D {}, new_cte =3D {};
      +    ITEntry old_ite =3D {};
           ItsCmdResult cmdres;
      =20
           devid =3D FIELD_EX64(cmdpkt[0], MOVI_0, DEVICEID);
      @@ -965,7 +965,7 @@ static bool update_vte(GICv3ITSState *s, uint32_t vpeid=
      , const VTEntry *vte)
      =20
       static ItsCmdResult process_vmapp(GICv3ITSState *s, const uint64_t *cmdpkt)
       {
      -    VTEntry vte;
      +    VTEntry vte =3D {};
           uint32_t vpeid;
      =20
           if (!its_feature_virtual(s)) {
      @@ -1030,7 +1030,7 @@ static void vmovp_callback(gpointer data, gpointer op=
      aque)
            */
           GICv3ITSState *s =3D data;
           VmovpCallbackData *cbdata =3D opaque;
      -    VTEntry vte;
      +    VTEntry vte =3D {};
           ItsCmdResult cmdres;
      =20
           cmdres =3D lookup_vte(s, __func__, cbdata->vpeid, &vte);
      @@ -1085,9 +1085,9 @@ static ItsCmdResult process_vmovi(GICv3ITSState *s, c=
      onst uint64_t *cmdpkt)
       {
           uint32_t devid, eventid, vpeid, doorbell;
           bool doorbell_valid;
      -    DTEntry dte;
      -    ITEntry ite;
      -    VTEntry old_vte, new_vte;
      +    DTEntry dte =3D {};
      +    ITEntry ite =3D {};
      +    VTEntry old_vte =3D {}, new_vte =3D {};
           ItsCmdResult cmdres;
      =20
           if (!its_feature_virtual(s)) {
      @@ -1186,10 +1186,10 @@ static ItsCmdResult process_vinvall(GICv3ITSState *=
      s, const uint64_t *cmdpkt)
       static ItsCmdResult process_inv(GICv3ITSState *s, const uint64_t *cmdpkt)
       {
           uint32_t devid, eventid;
      -    ITEntry ite;
      -    DTEntry dte;
      -    CTEntry cte;
      -    VTEntry vte;
      +    ITEntry ite =3D {};
      +    DTEntry dte =3D {};
      +    CTEntry cte =3D {};
      +    VTEntry vte =3D {};
           ItsCmdResult cmdres;
      =20
           devid =3D FIELD_EX64(cmdpkt[0], INV_0, DEVICEID);
      --=20
      2.34.1
    QEMU_EOF
    system 'patch -Np1 -i qemu_patch'

    # Avoid linux/usbdevice_fs.h:88:9: error: unknown type name ‘u8’ error
    FileUtils.mkdir_p 'linux'
    FileUtils.cp "#{CREW_PREFIX}/include/linux/usbdevice_fs.h", 'linux/usbdevice_fs.h'
    system "sed -i 's,^\\([[:blank:]]*\\)u8,\\1__u8,g' linux/usbdevice_fs.h"
    system "sed -i 's,<linux/usbdevice_fs.h>,\"linux/usbdevice_fs.h\",g' hw/usb/host-libusb.c"
  end

  def self.build
    FileUtils.mkdir_p 'build'
    Dir.chdir 'build' do
      system "mold -run ../configure #{CREW_CONFIGURE_OPTIONS.sub(/--target.*/, '').gsub('vfpv3-d16', 'neon').gsub('--disable-dependency-tracking', '').sub(/--program-prefix.*?(?=\s|$)/, '').sub(/--program-suffix.*?(?=\s|$)/, '')} \
        --enable-kvm \
        --enable-lto"
      @counter = 1
      @counter_max = 20
      loop do
        break if Kernel.system "make -j #{CREW_NPROC}"

        puts "Make iteration #{@counter} of #{@counter_max}...".orange

        @counter += 1
        break if @counter > @counter_max
      end
    end
  end

  def self.install
    Dir.chdir 'build' do
      system "make DESTDIR=#{CREW_DEST_DIR} install"
    end
  end
end
