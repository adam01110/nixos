{osConfig, ...}:
# Per-user stylix customization layered on top of system-wide stylix theming.
let
  disabledTargets = import ./_disabled.nix {};

  sansSerifFont = osConfig.stylix.fonts.sansSerif.name;
in {
  stylix = {
    # Opacity values: slightly reduced for better readability with wallpapers.
    opacity = {
      applications = 0.95;
      desktop = 0.95;
      popups = 0.95;
      terminal = 0.95;
    };

    # Font sizes: consistent small sizing for information density.
    fonts.sizes = {
      applications = 10;
      desktop = 10;
      popups = 10;
      terminal = 10;
    };

    # Enable/disable specific stylix targets.
    targets =
      disabledTargets
      // {
        cava.rainbow.enable = true;

        zen-browser.profileNames = ["default"];
      };
  };

  # Keep zathura fonts consistent with the desktop.
  programs.zathura.options.font = sansSerifFont;
}
