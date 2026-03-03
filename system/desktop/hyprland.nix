{
  pkgs,
  inputs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) system;
in
  # System-wide hyprland setup using packages from the hyprland flake.
  {
    programs = {
      hyprland = {
        enable = true;
        withUWSM = true;
        xwayland.enable = true;

        # Use the hyprland package from the flake.
        package = inputs.hyprland.packages.${system}.hyprland;
        portalPackage = inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland;
      };

      # Remove uuctl support from uwsm.
      uwsm.package = pkgs.uwsm.override {uuctlSupport = false;};
    };

    hardware.graphics = let
      pkgs-unstable = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in {
      enable32Bit = true;

      package = pkgs-unstable.mesa;
      package32 = pkgs-unstable.pkgsi686Linux.mesa;
    };
  }
