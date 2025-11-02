{
  osConfig,
  pkgs,
  ...
}:

{
  imports = [ ./plugins.nix ];

  programs.equinix = {
    enable = true;

    equibop.enable = true;
    discord.enable = false;

    config = {
      autoUpdate = true;
      frameless = true;
      transparent = true;

      enabledThemes = [
        "midnight.css"
        "snippets.css"
      ];

      themeLinks = [
        "https://raw.githubusercontent.com/Augenbl1ck/Discord-Styles/refs/heads/main/expProfile.css"
        "https://raw.githubusercontent.com/yiruzu/vencord-snippets/refs/heads/main/snippets/BubbleUsernames/import.css"
        "https://raw.githubusercontent.com/mudrhiod/discord-iconpacks/refs/heads/master/vencord/solar/solar.css"
      ];
    };
  };
  xdg.configFile."equibop/themes/midnight.css".source = pkgs.replaceVars ./themes/midnight.css {
    sansSerifFont = osConfig.stylix.fonts.sansSerif.name;
    monospaceFont = osConfig.stylix.fonts.monospace.name;
  };

  xdg.configFile."equibop/themes/snippets.css".source = ./themes/snippets.css;
}
