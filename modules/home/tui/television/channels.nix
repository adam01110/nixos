{
  osConfig,
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (builtins) attrValues;
  inherit
    (lib)
    splitString
    getAttrFromPath
    ;
in {
  programs.television.package = pkgs.television.withPackages (
    _:
      attrValues {
        inherit
          (pkgs)
          tlrc
          gnused
          gawk
          coreutils
          procs
          procps
          just
          less
          ;
      }
      ++ (map (program: config.programs.${program}.package) [
        "zoxide"
        "bat"
        "man"
        "eza"
      ])
      ++ (map (path: (getAttrFromPath (splitString "." path) osConfig).package) [
        "services.flatpak"
        "systemd"
        "security.sudo-rs"
      ])
  );
}
