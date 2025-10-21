{
  config,
  lib,
  pkgs,
  ...
}:

{
  xdg.mimeApps.defaultApplications = {
    # uri
    "x-scheme-handler/https" = "zen.desktop";
    "x-scheme-handler/obsidian" = "obsidian.desktop";
    "x-scheme-handler/beeper" = "beeper.desktop";
    "x-scheme-handler/curseforge" = "org.prismlauncher.PrismLauncher.desktop";
    "x-scheme-handler/prismlauncher" = "org.prismlauncher.PrismLauncher.desktop";
    "x-scheme-handler/roblox-player" = "org.vinegarhq.Sober.desktop";
    "x-scheme-handler/roblox" = "org.vinegarhq.Sober.desktop";
    "x-scheme-handler/bitwarden" = "bitwarden.desktop";
    "x-scheme-handler/spice+unix" = "remote-viewer.desktop";
    "x-scheme-handler/spice" = "remote-viewer.desktop";
    "x-scheme-handler/spice+tls" = "remote-viewer.desktop";
    "x-scheme-handler/oo-office" = "onlyoffice-desktopeditors.desktop";
    "x-scheme-handler/zed" = "dev.zed.Zed.desktop";
    "x-scheme-handler/steam" = "steam.desktop";
    "x-scheme-handler/steamlink" = "steam.desktop";

    # other
    "application/x-virt-viewer" = "remote-viewer.desktop";
    "application/java-archive" = "java-java21-openjdk.desktop";

    # files
    "inode/directory" = "org.kde.dolphin.desktop";
    "application/x-modrinth-modpack+zip" = "org.prismlauncher.PrismLauncher.desktop";

    # audio
    "audio/x-ape" = "org.gnome.Decibels.desktop";
    "audio/flac" = "org.gnome.Decibels.desktop";
    "audio/x-vorbis+ogg" = "org.gnome.Decibels.desktop";
    "audio/mp2" = "org.gnome.Decibels.desktop";
    "audio/x-m4b" = "org.gnome.Decibels.desktop";
    "audio/x-aiff" = "org.gnome.Decibels.desktop";
    "audio/mp4" = "org.gnome.Decibels.desktop";
    "audio/x-opus+ogg" = "org.gnome.Decibels.desktop";
    "audio/mpeg" = "org.gnome.Decibels.desktop";
    "audio/x-speex" = "org.gnome.Decibels.desktop";
    "audio/x-wavpack" = "org.gnome.Decibels.desktop";
    "audio/aac" = "org.gnome.Decibels.desktop";
    "audio/vnd.wave" = "org.gnome.Decibels.desktop";

    # video
    "video/x-nsv" = "org.gnome.Showtime.desktop";
    "video/webm" = "org.gnome.Showtime.desktop";
    "video/x-mjpeg" = "org.gnome.Showtime.desktop";
    "video/mp2t" = "org.gnome.Showtime.desktop";
    "video/quicktime" = "org.gnome.Showtime.desktop";
    "video/x-anim" = "org.gnome.Showtime.desktop";
    "video/mpeg" = "org.gnome.Showtime.desktop";
    "video/x-ogm+ogg" = "org.gnome.Showtime.desktop";
    "video/vnd.rn-realvideo" = "org.gnome.Showtime.desktop";
    "video/3gpp2" = "org.gnome.Showtime.desktop";
    "video/x-ms-wmv" = "org.gnome.Showtime.desktop";
    "video/3gpp" = "org.gnome.Showtime.desktop";
    "application/vnd.ms-asf" = "org.gnome.Showtime.desktop";
    "video/mp4" = "org.gnome.Showtime.desktop";
    "video/dv" = "org.gnome.Showtime.desktop";
    "video/x-theora+ogg" = "org.gnome.Showtime.desktop";
    "video/x-flic" = "org.gnome.Showtime.desktop";
    "video/vnd.avi" = "org.gnome.Showtime.desktop";
    "video/x-flv" = "org.gnome.Showtime.desktop";
    "video/x-matroska" = "org.gnome.Showtime.desktop";
    "video/vnd.vivo" = "org.gnome.Showtime.desktop";
    "video/ogg" = "org.gnome.Showtime.desktop";
    "video/vnd.mpegurl" = "org.gnome.Showtime.desktop";

    # archives
    "application/x-tar" = "org.kde.ark.desktop";
    "application/x-lrzip-compressed-tar" = "org.kde.ark.desktop";
    "application/x-lzip" = "org.kde.ark.desktop";
    "application/x-archive" = "org.kde.ark.desktop";
    "application/x-stuffit" = "org.kde.ark.desktop";
    "application/x-xz" = "org.kde.ark.desktop";
    "application/x-source-rpm" = "org.kde.ark.desktop";
    "application/vnd.rar" = "org.kde.ark.desktop";
    "application/x-bcpio" = "org.kde.ark.desktop";
    "application/x-arj" = "org.kde.ark.desktop";
    "application/zip" = "org.kde.ark.desktop";
    "application/x-lrzip" = "org.kde.ark.desktop";
    "application/x-zstd-compressed-tar" = "org.kde.ark.desktop";
    "application/x-lzop" = "org.kde.ark.desktop";
    "application/x-tarz" = "org.kde.ark.desktop";
    "application/vnd.ms-cab-compressed" = "org.kde.ark.desktop";
    "application/x-lzip-compressed-tar" = "org.kde.ark.desktop";
    "application/x-sv4crc" = "org.kde.ark.desktop";
    "application/x-lz4-compressed-tar" = "org.kde.ark.desktop";
    "application/x-sv4cpio" = "org.kde.ark.desktop";
    "application/x-bzip2-compressed-tar" = "org.kde.ark.desktop";
    "application/x-compressed-tar" = "org.kde.ark.desktop";
    "application/x-lha" = "org.kde.ark.desktop";
    "application/x-xar" = "org.kde.ark.desktop";
    "application/x-lzma-compressed-tar" = "org.kde.ark.desktop";
    "application/x-lz4" = "org.kde.ark.desktop";
    "application/x-7z-compressed" = "org.kde.ark.desktop";
    "application/x-bzip2" = "org.kde.ark.desktop";
    "application/x-compress" = "org.kde.ark.desktop";
    "application/zlib" = "org.kde.ark.desktop";
    "application/x-rpm" = "org.kde.ark.desktop";
    "application/x-cpio" = "org.kde.ark.desktop";
    "application/x-lzma" = "org.kde.ark.desktop";
    "application/x-tzo" = "org.kde.ark.desktop";
    "application/x-cpio-compressed" = "org.kde.ark.desktop";
    "application/zstd" = "org.kde.ark.desktop";
    "application/x-xz-compressed-tar" = "org.kde.ark.desktop";
    "application/gzip" = "org.kde.ark.desktop";
    "application/vnd.debian.binary-package" = "org.kde.ark.desktop";

    # documents viewing
    "application/pdf" = "org.pwmt.zathura-pdf-mupdf.desktop";
    "application/epub+zip" = "org.pwmt.zathura-pdf-mupdf.desktop";
    "image/x-eps" = "org.pwmt.zathura-ps.desktop";
    "application/x-cb7" = "org.pwmt.zathura-cb.desktop";
    "application/oxps" = "org.pwmt.zathura-pdf-mupdf.desktop";
    "application/vnd.comicbook+zip" = "org.pwmt.zathura-cb.desktop";
    "image/vnd.djvu" = "org.pwmt.zathura-djvu.desktop";
    "application/vnd.comicbook-rar" = "org.pwmt.zathura-cb.desktop";
    "application/x-cbt" = "org.pwmt.zathura-cb.desktop";
    "image/vnd.djvu+multipage" = "org.pwmt.zathura-djvu.desktop";
    "application/postscript" = "org.pwmt.zathura-ps.desktop";
    "application/vnd.ms-xpsdocument" = "org.pwmt.zathura-pdf-mupdf.desktop";

    # document editing
    "application/vnd.oasis.opendocument.text" = "onlyoffice-desktopeditors.desktop";
    "application/vnd.apple.pages" = "onlyoffice-desktopeditors.desktop";
    "application/vnd.ms-word.template.macroEnabled.12" = "onlyoffice-desktopeditors.desktop";
    "application/vnd.sun.xml.writer" = "onlyoffice-desktopeditors.desktop";
    "application/vnd.ms-visio.template.main+xml" = "onlyoffice-desktopeditors.desktop";
    "application/vnd.ms-visio.stencil.main+xml" = "onlyoffice-desktopeditors.desktop";
    "application/vnd.oasis.opendocument.text-flat-xml" = "onlyoffice-desktopeditors.desktop";
    "application/vnd.ms-visio.drawing.macroEnabled.main+xml" = "onlyoffice-desktopeditors.desktop";
    "application/x-hwp" = "onlyoffice-desktopeditors.desktop";
    "application/vnd.ms-word.document.macroEnabled.12" = "onlyoffice-desktopeditors.desktop";
    "application/msword" = "onlyoffice-desktopeditors.desktop";
    "application/vnd.apple.keynote" = "onlyoffice-desktopeditors.desktop";
    "text/csv" = "onlyoffice-desktopeditors.desktop";
    "application/vnd.ms-powerpoint.presentation.macroEnabled.12" = "onlyoffice-desktopeditors.desktop";
    "application/vnd.oasis.opendocument.text-template" = "onlyoffice-desktopeditors.desktop";
    "application/rtf" = "onlyoffice-desktopeditors.desktop";
    "application/vnd.ms-visio.stencil.macroEnabled.main+xml" = "onlyoffice-desktopeditors.desktop";
    "application/vnd.oasis.opendocument.presentation" = "onlyoffice-desktopeditors.desktop";
    "application/vnd.ms-visio.drawing.main+xml" = "onlyoffice-desktopeditors.desktop";
    "application/vnd.apple.numbers" = "onlyoffice-desktopeditors.desktop";
    "application/vnd.oasis.opendocument.presentation-template" = "onlyoffice-desktopeditors.desktop";
    "application/vnd.oasis.opendocument.spreadsheet-flat-xml" = "onlyoffice-desktopeditors.desktop";
    "application/vnd.ms-excel" = "onlyoffice-desktopeditors.desktop";
    "application/msword-template" = "onlyoffice-desktopeditors.desktop";
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document" =
      "onlyoffice-desktopeditors.desktop";
    "application/vnd.openxmlformats-officedocument.spreadsheetml.template" =
      "onlyoffice-desktopeditors.desktop";
    "application/vnd.sun.xml.impress" = "onlyoffice-desktopeditors.desktop";
    "application/vnd.sun.xml.writer.template" = "onlyoffice-desktopeditors.desktop";
    "application/vnd.openxmlformats-officedocument.presentationml.presentation" =
      "onlyoffice-desktopeditors.desktop";
    "application/vnd.oasis.opendocument.spreadsheet-template" = "onlyoffice-desktopeditors.desktop";
    "application/vnd.ms-powerpoint.template.macroEnabled.12" = "onlyoffice-desktopeditors.desktop";
    "application/vnd.openxmlformats-officedocument.presentationml.slideshow" =
      "onlyoffice-desktopeditors.desktop";
    "application/vnd.oasis.opendocument.spreadsheet" = "onlyoffice-desktopeditors.desktop";
    "application/vnd.ms-visio.template.macroEnabled.main+xml" = "onlyoffice-desktopeditors.desktop";
    "application/vnd.ms-excel.sheet.macroEnabled.12" = "onlyoffice-desktopeditors.desktop";
    "application/vnd.openxmlformats-officedocument.wordprocessingml.template" =
      "onlyoffice-desktopeditors.desktop";
    "application/vnd.oasis.opendocument.graphics" = "onlyoffice-desktopeditors.desktop";
    "application/vnd.sun.xml.calc" = "onlyoffice-desktopeditors.desktop";
    "application/vnd.ms-powerpoint.slideshow.macroEnabled.12" = "onlyoffice-desktopeditors.desktop";
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" =
      "onlyoffice-desktopeditors.desktop";
    "application/vnd.oasis.opendocument.presentation-flat-xml" = "onlyoffice-desktopeditors.desktop";
    "application/vnd.ms-excel.template.macroEnabled.12" = "onlyoffice-desktopeditors.desktop";
    "application/vnd.openxmlformats-officedocument.presentationml.template" =
      "onlyoffice-desktopeditors.desktop";
    "application/vnd.ms-powerpoint" = "onlyoffice-desktopeditors.desktop";
    "application/vnd.ms-excel.sheet.binary.macroEnabled.12" = "onlyoffice-desktopeditors.desktop";

    # code
    "application/x-zerosize" = "dev.zed.Zed.desktop";
    "application/x-php" = "dev.zed.Zed.desktop";
    "text/css" = "dev.zed.Zed.desktop";
    "text/markdown" = "dev.zed.Zed.desktop";
    "application/x-shellscript" = "dev.zed.Zed.desktop";
    "text/x-makefile" = "dev.zed.Zed.desktop";
    "text/x-python" = "dev.zed.Zed.desktop";
    "application/x-cmakecache" = "dev.zed.Zed.desktop";
    "text/x-patch" = "dev.zed.Zed.desktop";
    "application/x-perl" = "dev.zed.Zed.desktop";
    "application/xml" = "dev.zed.Zed.desktop";
    "text/tcl" = "dev.zed.Zed.desktop";
    "application/sql" = "dev.zed.Zed.desktop";
    "text/x-pascal" = "dev.zed.Zed.desktop";
    "text/x-moc" = "dev.zed.Zed.desktop";
    "text/plain" = "dev.zed.Zed.desktop";
    "text/x-csrc" = "dev.zed.Zed.desktop";

    # image viewing
    "image/png" = "org.gnome.Loupe.desktop";
    "image/x-kodak-dcr" = "org.gnome.Loupe.desktop";
    "image/x-pentax-pef" = "org.gnome.Loupe.desktop";
    "video/x-mjpeg" = "org.gnome.Loupe.desktop";
    "image/x-portable-graymap" = "org.gnome.Loupe.desktop";
    "image/vnd.microsoft.icon" = "org.gnome.Loupe.desktop";
    "image/bmp" = "org.gnome.Loupe.desktop";
    "image/svg+xml" = "org.gnome.Loupe.desktop";
    "image/x-portable-anymap" = "org.gnome.Loupe.desktop";
    "image/x-exr" = "org.gnome.Loupe.desktop";
    "image/x-kodak-k25" = "org.gnome.Loupe.desktop";
    "image/heif" = "org.gnome.Loupe.desktop";
    "image/x-tga" = "org.gnome.Loupe.desktop";
    "image/x-sony-srf" = "org.gnome.Loupe.desktop";
    "image/x-canon-cr2" = "org.gnome.Loupe.desktop";
    "image/qoi" = "org.gnome.Loupe.desktop";
    "image/jxl" = "org.gnome.Loupe.desktop";
    "image/svg+xml-compressed" = "org.gnome.Loupe.desktop";
    "image/x-kodak-kdc" = "org.gnome.Loupe.desktop";
    "image/webp" = "org.gnome.Loupe.desktop";
    "image/x-sony-sr2" = "org.gnome.Loupe.desktop";
    "image/x-portable-pixmap" = "org.gnome.Loupe.desktop";
    "image/tiff" = "org.gnome.Loupe.desktop";
    "image/gif" = "org.gnome.Loupe.desktop";
    "image/x-dds" = "org.gnome.Loupe.desktop";
    "image/avif" = "org.gnome.Loupe.desktop";
    "image/x-sony-arw" = "org.gnome.Loupe.desktop";
    "image/x-portable-bitmap" = "org.gnome.Loupe.desktop";
    "image/x-adobe-dng" = "org.gnome.Loupe.desktop";
    "image/jpeg" = "org.gnome.Loupe.desktop";
    "image/x-nikon-nef" = "org.gnome.Loupe.desktop";

    # image editing
    "image/vnd.adobe.photoshop" = "krita_psd.desktop";
    "image/x-panasonic-rw" = "krita_raw.desktop";
    "image/openraster" = "krita_ora.desktop";
    "image/x-canon-crw" = "krita_raw.desktop";
    "image/jp2" = "krita_jp2.desktop";
    "image/x-minolta-mrw" = "krita_raw.desktop";
    "image/x-fuji-raf" = "krita_raw.desktop";
    "image/x-sigma-x3f" = "krita_raw.desktop";
    "image/x-olympus-orf" = "krita_raw.desktop";
    "image/x-xbitmap" = "krita_qimageio.desktop";
    "image/x-xcf" = "krita_xcf.desktop";
    "application/x-krita" = "krita_kra.desktop";
    "image/jpx" = "krita_jp2.desktop";
    "image/x-xpixmap" = "krita_qimageio.desktop";
    "image/x-panasonic-rw2" = "krita_raw.desktop";
  };
}
