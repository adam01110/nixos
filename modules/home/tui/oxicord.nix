{
  # keep-sorted start
  config,
  lib,
  osConfig,
  pkgs,
  # keep-sorted end
  ...
}:
# Configure oxicord and expose a desktop launcher.
let
  inherit (lib) getExe;

  tomlFormat = pkgs.formats.toml {};

  oxicordPkg = pkgs.oxicord;
  accentColor = "#${osConfig.lib.stylix.colors.base0B}";
in {
  home.packages = [oxicordPkg];

  # Generate a minimal oxicord configuration with changed values.
  xdg.configFile."oxicord/config.toml".source = tomlFormat.generate "oxicord-config.toml" {
    ui.group_guilds = true;
    theme.accent_color = accentColor;
  };

  # Create desktop entry to allow launching via launcher.
  xdg.desktopEntries.oxicord = {
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
}
