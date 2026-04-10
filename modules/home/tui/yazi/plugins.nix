{
  # keep-sorted start
  config,
  lib,
  osConfig,
  pkgs,
  # keep-sorted end
  ...
}:
# Register plugins that do not have dedicated module files.
let
  inherit
    (builtins)
    # keep-sorted start
    attrValues
    listToAttrs
    # keep-sorted end
    ;
  inherit
    (lib)
    # keep-sorted start
    getAttrFromPath
    splitString
    # keep-sorted end
    ;
  inherit (pkgs.lib.attrsets) nameValuePair;
in {
  programs.yazi = {
    # Drop Yazi's builtin fzf and zoxide helpers from the wrapped runtime.
    optionalDeps =
      attrValues {
        inherit
          (pkgs)
          # keep-sorted start
          _7zz
          chafa
          ffmpeg
          imagemagick
          jq
          poppler-utils
          resvg
          # keep-sorted end
          ;
      }
      # Reuse packages from home-manager modules to avoid duplicate package selections.
      ++ (map (program: config.programs.${program}.package) [
        # keep-sorted start
        "fd"
        "ripgrep"
        # keep-sorted end
      ]);

    # Add runtime helpers for yazi plugins..package = pkgs.yazi.override {
    extraPackages =
      attrValues {
        inherit
          (pkgs)
          # keep-sorted start
          # spot
          coreutils
          # preview-epub
          gnome-epub-thumbnailer
          # spot-image
          inkscape
          # mediainfo & spot-audio
          mediainfo
          # recycle-bin
          trash-cli
          # preview-cbz
          unrar
          # spot-cbz & preview-cbz
          unzip
          # mount
          util-linux
          # ucp
          wl-clipboard
          # keep-sorted end
          # faster-piper
          glow
          sqlite
          ;
      }
      # Reuse packages from home-manager modules to avoid duplicate package selections.
      ++ (map (program: config.programs.${program}.package) [
        # keep-sorted start
        "bat"
        "git"
        "television"
        # keep-sorted end
      ])
      # Pull packaged tools from the system config when home-manager does not own them.
      ++ (map (path: (getAttrFromPath (splitString "." path) osConfig).package) [
        "services.udisks2"
      ]);

    plugins = let
      mkPlugin = source: name: nameValuePair name source.${name};

      # Plugins from nixpkgs.
      nixpkgsPlugins = [
        # keep-sorted start
        "full-border"
        "git"
        "starship"
        # keep-sorted end
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
  };
}
