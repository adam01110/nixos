{
  osConfig,
  pkgs,
  ...
}:

# configure lutris and integrate with steam packages.
let
  bluetoothEnabled = osConfig.optServices.bluetooth.enable or false;

  slimLutris = pkgs.callPackage (
    {
      lib,
      buildFHSEnv,
      lutris-unwrapped,
      extraPkgs ? pkgs: [ ],
      extraLibraries ? pkgs: [ ],
      steamSupport ? true,
    }:
    let
      qt5Deps =
        pkgs: with pkgs.qt5; [
          qtbase
          qtmultimedia
        ];
      qt6Deps = pkgs: with pkgs.qt6; [ qtbase ];
      gnomeDeps =
        pkgs: with pkgs; [
          zenity
          gtksourceview
          libgnome-keyring
          webkitgtk_4_1
          adwaita-icon-theme
        ];
      xorgDeps =
        pkgs: with pkgs.xorg; [
          libX11
          libXrender
          libXrandr
          libxcb
          libXmu
          libpthreadstubs
          libXext
          libXdmcp
          libXxf86vm
          libXinerama
          libSM
          libXv
          libXaw
          libXi
          libXcursor
          libXcomposite
          libXfixes
          libXtst
          libXScrnSaver
          libICE
          libXt
        ];
      gstreamerDeps =
        pkgs: with pkgs.gst_all_1; [
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

      targetPkgs =
        pkgs:
        with pkgs;
        [
          lutris-unwrapped

          # Appimages
          fuse

          # Curl
          libnghttp2

          # Dolphin
          ffmpeg_6
          gettext
          portaudio
          miniupnpc
          mbedtls
          lzo
          sfml
          gsm
          wavpack
          orc
          nettle
          gmp
          pcre
          vulkan-loader
          zstd

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

      multiPkgs =
        pkgs:
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

      # allows for some gui applications to share IPC
      # this fixes certain issues where they don't render correctly
      unshareIpc = false;

      # Some applications such as Natron need access to MIT-SHM or other
      # shared memory mechanisms. Unsharing the pid namespace
      # breaks the ability for application to reference shared memory.
      unsharePid = false;

      meta = {
        inherit (lutris-unwrapped.meta)
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
  ) { };
in
{
  config.programs.lutris = {
    enable = true;

    package = slimLutris;

    # add umu launcher for proton outside of steam.
    extraPackages = [ pkgs.umu-launcher ];

    # proton and the package of steam form the system steam module.
    steamPackage = osConfig.programs.steam.package;
    protonPackages = osConfig.programs.steam.extraCompatPackages;
  };
}
