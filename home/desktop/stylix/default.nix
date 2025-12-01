{
  osConfig,
  pkgs,
  ...
}:

# per-user stylix customization layered on top of system stylix.
let
  disabledTargets = import ./disabled.nix { };

  sansSerifFont = osConfig.stylix.fonts.sansSerif.name;
in
{
  imports = [
    ./equibop.nix
    ./eza.nix
    ./hyprcursor.nix
    ./hyprland.nix
    ./noctalia.nix
  ];

  stylix = {
    cursor = {
      name = "Bibata-Modern-Gruvbox-Dark";
      package = pkgs.nur.repos.adam0.bibata-modern-cursors-gruvbox-dark;
      size = 24;
    };

    icons = {
      enable = true;
      light = "Gruvbox-Plus-Dark";
      dark = "Gruvbox-Plus-Dark";
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

    # enable/disable specific stylix targets.
    targets = disabledTargets // {
      cava.rainbow.enable = true;

      zen-browser.profileNames = [ "default" ];
    };
  };

  # keep zathura fonts consistent with the desktop.
  programs.zathura.options.font = sansSerifFont;
}
