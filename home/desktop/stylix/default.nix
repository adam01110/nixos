{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}:

let
  sansSerifFont = osConfig.stylix.fonts.sansSerif.name;
in
{
  imports = [
    ./eza.nix
    ./hyprcursor.nix
    ./hyprland.nix
    ./noctalia.nix
  ];

  stylix = {
    cursor = {
      name = "Bibata-Modern-Gruvbox";
      package = pkgs.nur.repos.adam0.bibata-cursors-gruvbox;
    };

    icons = {
      enable = true;
      light = "Gruvbox Plus Dark";
      dark = "Gruvbox Plus Dark";
      package = pkgs.gruvbox-plus-icons;
    };

    opacity = {
      applications = 0.95;
      desktop = 0.95;
      popups = 0.95;
      terminal = 0.95;
    };

    fonts.sizes = {
      applications = 10;
      desktop = 10;
      popups = 10;
      terminal = 10;
    };

    targets.obsidian.enable = false;
  };

  programs.zathura.options.font = sansSerifFont;
  qt.style.package = pkgs.nur.repos.shadowrz.klassy;
}
