{
  # keep-sorted start
  config,
  flakeLib,
  osConfig,
  pkgs,
  # keep-sorted end
  ...
}: let
  inherit (builtins) attrValues;
  inherit (flakeLib) packagesByPath;
in {
  programs.television.package = pkgs.television.withPackages (
    _:
    # Bundle tools that channel commands shell out to.
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
        "git"
        "delta"
        "man"
        "opencode"
        "zoxide"
        # keep-sorted end
      ])
      # Pull packaged tools from the system config when home-manager does not own them.
      ++ (packagesByPath osConfig [
        # keep-sorted start
        "security.sudo-rs"
        "services.flatpak"
        "systemd"
        # keep-sorted end
      ])
  );
}
