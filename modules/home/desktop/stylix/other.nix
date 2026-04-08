{osConfig, ...}:
# Configure some stylix targets.
let
  sansSerifFont = osConfig.stylix.fonts.sansSerif.name;
  MonospaceFont = osConfig.stylix.fonts.monospace.name;
in {
  stylix.
  targets = {
    # Cava.
    cava.rainbow.enable = true;

    # Zen-browser.
    zen-browser.profileNames = ["default"];

    # Neovim.
    nvf.transparentBackground = true;
  };

  programs = {
    # Keep zathura fonts consistent.
    zathura.options.font = sansSerifFont;

    prismlauncher.settings.Consolefont = MonospaceFont;
  };
}
