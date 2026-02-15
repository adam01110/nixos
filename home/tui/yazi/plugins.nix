{pkgs, ...}:
# Register plugins that do not have dedicated module files.
let
  inherit (builtins) attrValues listToAttrs;
  inherit (pkgs.lib.attrsets) nameValuePair;
in {
  # Add runtime helpers for yazi plugins.
  programs.yazi.package = pkgs.yazi.override {
    extraPackages = attrValues {
      inherit
        (pkgs)
        # mediainfo & spot-audio
        mediainfo
        # ucp
        wl-clipboard
        # faster-piper
        glow
        sqlite
        # recycle-bin
        trash-cli
        # spot
        coreutils
        # spot-audio & spot-video
        ffmpeg
        # spot-image
        imagemagick
        inkscape
        # spot-cbz & preview-cbz
        unzip
        # preview-git
        git
        # preview-cbz
        unrar
        # preview-epub
        gnome-epub-thumbnailer
        ;
    };
  };

  programs.yazi.plugins = let
    mkPlugin = source: name: nameValuePair name source.${name};

    # Plugins from nixpkgs.
    nixpkgsPlugins = [
      "full-border"
      "git"
      "starship"
    ];

    # Plugins from adam0's nur.
    adam0Plugins = ["spot"];

    # Plugins from xyenon's nur.
    xyenonPlugins = ["types"];
  in
    listToAttrs (
      (map (mkPlugin pkgs.yaziPlugins) nixpkgsPlugins)
      ++ (map (mkPlugin pkgs.nur.repos.adam0.yaziPlugins) adam0Plugins)
      ++ (map (mkPlugin pkgs.nur.repos.xyenon.yaziPlugins.yazi-rs) xyenonPlugins)
    );
}
