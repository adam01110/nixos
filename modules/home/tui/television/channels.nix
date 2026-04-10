{
  # keep-sorted start
  config,
  lib,
  osConfig,
  pkgs,
  # keep-sorted end
  ...
}:
# Bundle television channel command dependencies.
let
  inherit (builtins) attrValues;
  inherit
    (lib)
    # keep-sorted start
    getAttrFromPath
    splitString
    # keep-sorted end
    ;
in {
  programs.television.package = pkgs.television.withPackages (
    _:
    # Bundle standalone cli tools that channel commands shell out to.
      attrValues {
        inherit
          (pkgs)
          # keep-sorted start
          bash
          coreutils
          gawk
          gnused
          jq
          just
          less
          procps
          procs
          tlrc
          trash-cli
          # keep-sorted end
          ;
      }
      # Reuse packages from home-manager modules to avoid duplicate package selections.
      ++ (map (program: config.programs.${program}.package) [
        # keep-sorted start
        "bat"
        "eza"
        "man"
        "opencode"
        "zoxide"
        # keep-sorted end
      ])
      # Pull packaged tools from the system config when home-manager does not own them.
      ++ (map (path: (getAttrFromPath (splitString "." path) osConfig).package) [
        # keep-sorted start
        "security.sudo-rs"
        "services.flatpak"
        "systemd"
        # keep-sorted end
      ])
  );
}
