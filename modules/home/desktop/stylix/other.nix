{osConfig, ...}: let
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
    cava.rainbow.enable = true;

    nvf.transparentBackground = true;

    zen-browser.profileNames = ["default"];
    # keep-sorted end
  };
  # keep-sorted end
}
