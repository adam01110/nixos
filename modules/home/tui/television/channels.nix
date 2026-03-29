{
  osConfig,
  config,
  lib,
  pkgs,
  ...
}:
# Bundle television channel command dependencies.
let
  inherit (builtins) attrValues;
  inherit
    (lib)
    splitString
    getAttrFromPath
    ;
in {
  programs.television.package = pkgs.television.withPackages (
    _:
    # Bundle standalone cli tools that channel commands shell out to.
      attrValues {
        inherit
          (pkgs)
          tlrc
          trash-cli
          gnused
          gawk
          coreutils
          procs
          procps
          just
          less
          ;
      }
      # Reuse packages from home-manager modules to avoid duplicate package selections.
      ++ (map (program: config.programs.${program}.package) [
        "zoxide"
        "bat"
        "man"
        "eza"
      ])
      # Pull packaged tools from the system config when home-manager does not own them.
      ++ (map (path: (getAttrFromPath (splitString "." path) osConfig).package) [
        "services.flatpak"
        "systemd"
        "security.sudo-rs"
      ])
  );
}
