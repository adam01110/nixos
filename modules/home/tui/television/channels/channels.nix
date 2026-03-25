{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) getExe;

  inherit (config.xdg) configHome;

  bat = getExe pkgs.bat;
  tv = getExe pkgs.television;
in {
  programs.television.channels.channels = {
    metadata = {
      name = "channels";
      description = "Select a television channel";
      requirements = [
        "tv"
        "bat"
      ];
    };

    source.command = "${tv} list-channels";

    preview.command = "${bat} -pn --color always ${configHome}/television/cable/**/{}.toml";

    keybindings.enter = "actions:channel-enter";

    actions.channel-enter = {
      description = "Enter a television channel";
      command = "${tv} {}";
      mode = "execute";
    };
  };
}
