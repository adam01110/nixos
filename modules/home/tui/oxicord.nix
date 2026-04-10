{
  # keep-sorted start
  config,
  flakeLib,
  osConfig,
  pkgs,
  # keep-sorted end
  ...
}: let
  inherit (pkgs.lib) getExe;
  inherit (flakeLib) stylixHexColor;

  tomlFormat = pkgs.formats.toml {};

  oxicordPkg = pkgs.oxicord;
  accentColor = stylixHexColor "base0B" osConfig;
in {
  # keep-sorted start block=yes newline_separated=yes
  home.packages = [oxicordPkg];

  xdg = {
    # keep-sorted start block=yes newline_separated=yes
    # Generate oxicord configuration.
    configFile."oxicord/config.toml".source = tomlFormat.generate "oxicord-config.toml" {
      ui.group_guilds = true;
      theme.accent_color = accentColor;
    };

    # Create desktop entry to allow launching via launcher.
    desktopEntries.oxicord = {
      name = "Oxicord";
      genericName = "Terminal Discord Client";
      icon = "discord";

      exec = let
        # keep-sorted start
        oxicord = getExe oxicordPkg;
        terminalCommand = getExe config.xdg.terminal-exec.package;
        # keep-sorted end
      in "${terminalCommand} --title=Oxicord ${oxicord}";

      categories = [
        # keep-sorted start
        "Chat"
        "ConsoleOnly"
        "InstantMessaging"
        "Network"
        # keep-sorted end
      ];
    };
    # keep-sorted end
  };
  # keep-sorted end
}
