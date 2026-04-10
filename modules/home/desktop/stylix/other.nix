{osConfig, ...}:
# Configure some stylix targets.
let
  # keep-sorted start
  MonospaceFont = osConfig.stylix.fonts.monospace.name;
  sansSerifFont = osConfig.stylix.fonts.sansSerif.name;
  # keep-sorted end
in {
  # keep-sorted start block=yes newline_separated=yes
  programs = {
    # keep-sorted start newline_separated=yes
    prismlauncher.settings.Consolefont = MonospaceFont;

    # Keep zathura fonts consistent.
    zathura.options.font = sansSerifFont;
    # keep-sorted end
  };

  stylix.targets = {
    # keep-sorted start newline_separated=yes
    # Cava.
    cava.rainbow.enable = true;

    # Neovim.
    nvf.transparentBackground = true;

    # Zen-browser.
    zen-browser.profileNames = ["default"];
    # keep-sorted end
  };
  # keep-sorted end
}
