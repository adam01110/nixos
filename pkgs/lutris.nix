{
  lib,
  buildFHSEnv,
  lutris-unwrapped,
  extraPkgs ? _pkgs: [],
  extraLibraries ? _pkgs: [],
  bluetoothEnabled ? false,
  steamSupport ? true,
  ...
}:
# Slim lutris provides minimal lutris with essential dependencies.
let
  qt5Deps = pkgs:
    with pkgs.qt5; [
      qtbase
      qtmultimedia
    ];
  qt6Deps = pkgs: with pkgs.qt6; [qtbase];
  gnomeDeps = pkgs:
    with pkgs; [
      zenity
      gtksourceview
      libgnome-keyring
      webkitgtk_4_1
      adwaita-icon-theme
    ];
  xorgDeps = pkgs:
    with pkgs; [
      libx11
      libxrender
      libxrandr
      libxcb
      libxmu
      libpthread-stubs
      libxext
      libxdmcp
      libxxf86vm
      libxinerama
      libsm
      libxv
      libxaw
      libxi
      libxcursor
      libxcomposite
      libxfixes
      libxtst
      libxscrnsaver
      libice
      libxt
    ];
  gstreamerDeps = pkgs:
    with pkgs.gst_all_1; [
      gstreamer
      gst-plugins-base
      gst-plugins-good
      gst-plugins-ugly
      gst-plugins-bad
      gst-libav
    ];
in
  buildFHSEnv {
    pname = "lutris";
    inherit (lutris-unwrapped) version;
    runScript = "lutris";
    multiArch = true;

    targetPkgs = pkgs:
      with pkgs;
        [
          lutris-unwrapped

          # Appimages
          fuse

          # Curl
          libnghttp2

          # GOG
          glib-networking

          # WINE
          xorg.xrandr
          perl
          which
          p7zip
          gnused
          gnugrep
          psmisc
          opencl-headers
        ]
        ++ qt5Deps pkgs
        ++ qt6Deps pkgs
        ++ gnomeDeps pkgs
        ++ lib.optional bluetoothEnabled pkgs.bluez
        ++ lib.optional steamSupport pkgs.steam
        ++ extraPkgs pkgs;

    multiPkgs = pkgs:
      with pkgs;
        [
          # Common
          libsndfile
          libtheora
          libogg
          libvorbis
          libopus
          libGLU
          libpcap
          libpulseaudio
          libao
          libevdev
          udev
          libgcrypt
          libxml2
          libusb1
          libpng
          libmpeg2
          libv4l
          libjpeg
          libxkbcommon
          libass
          libcdio
          libjack2
          libsamplerate
          libzip
          libmad
          libaio
          libcap
          libtiff
          libva
          libgphoto2
          libxslt
          libsndfile
          giflib
          zlib
          glib
          alsa-lib
          zziplib
          bash
          dbus
          keyutils
          zip
          cabextract
          freetype
          unzip
          coreutils
          readline
          gcc
          SDL
          SDL2
          curl
          graphite2
          gtk2
          gtk3
          udev
          ncurses
          wayland
          libglvnd
          vulkan-loader
          xdg-utils
          sqlite
          gnutls
          p11-kit
          libbsd
          harfbuzz

          # PCSX2 // TODO: "libgobject-2.0.so.0: wrong ELF class: ELFCLASS64"

          # WINE
          cups
          lcms2
          mpg123
          cairo
          unixODBC
          samba4
          sane-backends
          openldap
          ocl-icd
          util-linux
          libkrb5

          # Proton
          libselinux

          # Winetricks
          fribidi
          pango
        ]
        ++ xorgDeps pkgs
        ++ gstreamerDeps pkgs
        ++ extraLibraries pkgs;

    extraInstallCommands = ''
      mkdir -p $out/share
      ln -sf ${lutris-unwrapped}/share/applications $out/share
      ln -sf ${lutris-unwrapped}/share/icons $out/share
    '';

    # Allows for some gui applications to share IPC
    # This fixes certain issues where they don't render correctly
    unshareIpc = false;

    # Some applications such as Natron need access to MIT-SHM or other
    # Shared memory mechanisms. Unsharing the pid namespace
    # Breaks the ability for application to reference shared memory.
    unsharePid = false;

    meta = {
      inherit
        (lutris-unwrapped.meta)
        homepage
        description
        platforms
        license
        maintainers
        broken
        ;

      mainProgram = "lutris";
    };
  }
