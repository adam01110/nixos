{
  # keep-sorted start
  inputs,
  pkgs,
  # keep-sorted end
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) system;
in {
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
