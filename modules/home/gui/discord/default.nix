{
  # keep-sorted start
  config,
  equibopStylix,
  osConfig,
  pkgs,
  # keep-sorted end
  ...
}: let
  inherit
    (builtins)
    # keep-sorted start
    attrNames
    readFile
    
    replaceStrings
    # keep-sorted end
    ;

  inherit (config.xdg) configHome;

  themeVars = equibopStylix.palette // {monospaceFont = osConfig.stylix.fonts.monospace.name;};

  system24Theme = pkgs.writeText "system24.css" (
    replaceStrings
    (map (name: "__${name}__") (attrNames themeVars))
    (map (name: themeVars.${name}) (attrNames themeVars))
    (readFile ./themes/system24.css)
  );
in {
  # keep-sorted start block=yes newline_separated=yes
  programs.nixcord = {
    enable = true;
    discord.enable = false;

    equibop = {
      enable = true;

      configDir = "${configHome}/equibop";

      package =
        pkgs.equibop
        // {
          # Nixcord still passes electron, but nixpkgs now hardcodes electron_40.
          override = args: pkgs.equibop.override (removeAttrs args ["electron"]);
        };

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

  # Add snippets stylesheet for additional styling.
  xdg.configFile."equibop/themes/snippets.css".source = ./themes/snippets.css;

  # Install themed css with fonts and palette from Stylix.
  xdg.configFile."equibop/themes/system24.css".source = system24Theme;
  # keep-sorted end
}
