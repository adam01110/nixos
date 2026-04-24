{
  config,
  equibopStylix,
  osConfig,
  pkgs,
  ...
}: let
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

  # Install themed css with fonts and palette from Stylix.
  xdg.configFile."equibop/themes/system24.css".source = replaceVars ./themes/system24.css {
    inherit
      (equibopStylix.palette)
      base00
      base01
      base02
      base03
      base04
      base05
      base06
      base07
      base08
      base09
      base0A
      base0B
      base0C
      base0D
      base0E
      base0F
      ;

    monospaceFont = osConfig.stylix.fonts.monospace.name;
  };
  # keep-sorted end
}
