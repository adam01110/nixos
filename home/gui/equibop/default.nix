{
  config,
  osConfig,
  pkgs,
  ...
}:
# set up discord with nixcord and equibop.
let
  inherit (pkgs) replaceVars;
  inherit (config.xdg) configHome;
in {
  imports = [./plugins.nix];

  programs.nixcord = {
    enable = true;
    discord.enable = false;

    equibop = {
      enable = true;

      configDir = "${configHome}/equibop";

      settings = {
        discordBranch = "stable";
        minimizeToTray = true;
        arRPC = true;
        autoStartMinimized = true;
        hardwareVideoAcceleration = true;
        customTitleBar = false;
        splashProgress = true;
        clickTrayToShowHide = true;
      };
    };

    # write main equibop configuration.
    config = {
      autoUpdate = true;
      frameless = true;
      transparent = true;

      # enable custom css themes.
      enabledThemes = [
        "system24.css"
        "snippets.css"
      ];

      # load external theme links for enhanced styling.
      themeLinks = [
        "https://raw.githubusercontent.com/Augenbl1ck/Discord-Styles/refs/heads/main/expProfile.css"
        "https://raw.githubusercontent.com/yiruzu/vencord-snippets/refs/heads/main/snippets/BubbleUsernames/import.css"
        "https://raw.githubusercontent.com/mudrhiod/discord-iconpacks/refs/heads/master/vencord/solar/solar.css"
      ];
    };
  };

  # install themed css with fonts from stylix.
  xdg.configFile."equibop/themes/system24.css".source = replaceVars ./themes/system24.css {
    monospaceFont = osConfig.stylix.fonts.monospace.name;
  };

  # add snippets stylesheet for additional styling.
  xdg.configFile."equibop/themes/snippets.css".source = ./themes/snippets.css;
}
