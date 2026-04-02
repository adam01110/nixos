{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}:
# Register plugins that do not have dedicated module files.
let
  inherit (builtins) attrValues listToAttrs;
  inherit
    (lib)
    getAttrFromPath
    splitString
    ;
  inherit (pkgs.lib.attrsets) nameValuePair;
in {
  # Add runtime helpers for yazi plugins.
  programs.yazi.package = pkgs.yazi.override {
    # Drop Yazi's builtin fzf and zoxide helpers from the wrapped runtime.
    optionalDeps =
      attrValues {
        inherit
          (pkgs)
          jq
          poppler-utils
          _7zz
          ffmpeg
          imagemagick
          chafa
          resvg
          ;
      }
      # Reuse packages from home-manager modules to avoid duplicate package selections.
      ++ (map (program: config.programs.${program}.package) [
        "fd"
        "ripgrep"
      ]);

    extraPackages =
      attrValues {
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
          # spot-image
          inkscape
          # spot-cbz & preview-cbz
          unzip
          # preview-cbz
          unrar
          # preview-epub
          gnome-epub-thumbnailer
          # mount
          util-linux
          ;
      }
      # Reuse packages from home-manager modules to avoid duplicate package selections.
      ++ (map (program: config.programs.${program}.package) [
        "git"
        "television"
        "bat"
      ])
      # Pull packaged tools from the system config when home-manager does not own them.
      ++ (map (path: (getAttrFromPath (splitString "." path) osConfig).package) [
        "services.udisks2"
      ]);
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
