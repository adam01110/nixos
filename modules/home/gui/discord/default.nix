{
  config,
  osConfig,
  pkgs,
  ...
}:
# Set up discord with nixcord and equibop.
let
  inherit (pkgs) replaceVars;
  inherit (config.xdg) configHome;
in {
  programs.nixcord = {
    enable = true;
    discord.enable = false;

    equibop = {
      enable = true;

      configDir = "${configHome}/equibop";

      settings = {
        # keep-sorted start
        arRPC = true;
        autoStartMinimized = true;
        clickTrayToShowHide = true;
        customTitleBar = false;
        hardwareVideoAcceleration = true;
        minimizeToTray = true;
        splashProgress = true;
        # keep-sorted end
        discordBranch = "stable";
      };
    };

    # Write main equibop configuration.
    config = {
      # keep-sorted start
      autoUpdate = true;
      frameless = true;
      transparent = true;
      # keep-sorted end

      # Enable custom css themes.
      enabledThemes = [
        # keep-sorted start
        "snippets.css"
        "system24.css"
        # keep-sorted end
      ];

      # Load external theme links for enhanced styling.
      themeLinks = [
        # keep-sorted start
        "https://raw.githubusercontent.com/Augenbl1ck/Discord-Styles/refs/heads/main/expProfile.css"
        "https://raw.githubusercontent.com/mudrhiod/discord-iconpacks/refs/heads/master/vencord/solar/solar.css"
        "https://raw.githubusercontent.com/yiruzu/vencord-snippets/refs/heads/main/snippets/BubbleUsernames/import.css"
        # keep-sorted end
      ];
    };
  };

  # keep-sorted start block=yes newline_separated=yes
  # Add snippets stylesheet for additional styling.
  xdg.configFile."equibop/themes/snippets.css".source = ./themes/snippets.css;

  # Install themed css with fonts from stylix.
  xdg.configFile."equibop/themes/system24.css".source = replaceVars ./themes/system24.css {
    monospaceFont = osConfig.stylix.fonts.monospace.name;
  };
  # keep-sorted end
}
