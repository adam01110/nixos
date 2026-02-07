{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}:
# Configure oxicord and expose a desktop launcher.
let
  inherit
    (lib)
    getExe
    ;

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
      terminalCommand = getExe config.xdg.terminal-exec.package;
      oxicord = getExe oxicordPkg;
    in "${terminalCommand} --title=Oxicord ${oxicord}";
    categories = [
      "Network"
      "Chat"
      "Utility"
    ];
  };
}
