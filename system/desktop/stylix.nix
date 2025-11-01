{
  config,
  lib,
  pkgs,
  system,
  ...
}:

{
  stylix = {
    enable = true;

    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark.yaml";

    cursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.nur.repos.adam0.bibata-modern-cursors-classic;
      size = 24;
    };

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
}
