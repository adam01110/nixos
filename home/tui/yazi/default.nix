{
  pkgs,
  lib,
  ...
}:
# yazi tui file manager.
let
  inherit (builtins) attrValues;
  inherit (lib) makeBinPath;
  inherit
    (pkgs)
    symlinkJoin
    makeWrapper
    ;
in {
  imports = [
    ./plugins.nix
    ./settings.nix
    ./theme.nix
  ];

  # wrap yazi with plugin dependencies.
  programs.yazi = {
    enable = true;

    package = symlinkJoin {
      name = "yazi-wrapped";
      paths = [pkgs.yazi];
      nativeBuildInputs = [makeWrapper];
      postBuild = ''
        wrapProgram $out/bin/yazi \
          --prefix PATH : ${makeBinPath (attrValues {
          inherit
            (pkgs)
            mediainfo
            wl-clipboard
            glow
            ;
        })}
      '';
    };

    initLua = ./init.lua;

    shellWrapperName = "y";
  };
}
