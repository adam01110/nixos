{pkgs, ...}:
# System stylix theme: colors, fonts, and cursor.
{
  stylix = {
    enable = true;

    polarity = "dark";

    # Tweaked default tinted gruvbox-dark colorscheme to use the lighter colors.
    base16Scheme = {
      base00 = "#282828";
      base01 = "#3c3836";
      base02 = "#504945";
      base03 = "#665c54";
      base04 = "#928374";
      base05 = "#ebdbb2";
      base06 = "#fbf1c7";
      base07 = "#f9f5d7";
      base08 = "#fb4934";
      base09 = "#fe8019";
      base0A = "#fabd2f";
      base0B = "#b8bb26";
      base0C = "#8ec07c";
      base0D = "#83a598";
      base0E = "#d3869b";
      base0F = "#9d0006";
    };

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

    # Use JetBrainsMono without ligatures.
    fonts = {
      serif = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMonoNL Nerd Font Propo";
      };

      sansSerif = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMonoNL Nerd Font Propo";
      };

      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMonoNL Nerd Font Mono";
      };
    };
  };

  # Cjk font.
  fonts.packages = [pkgs.noto-fonts-cjk-sans];
}
