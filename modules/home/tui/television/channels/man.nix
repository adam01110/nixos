{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) getExe;

  bat = getExe config.programs.bat.package;
  man = getExe config.programs.man.package;
  sed = getExe pkgs.gnused;
in {
  programs.television.channels.man = {
    metadata = {
      name = "man";
      description = "Browse and preview system manual pages";
      requirements = [
        "man"
        "bat"
        "sed"
      ];
    };

    source.command = "${man} -k .";

    preview = {
      command = "MANPAGER=cat MANROFFOPT=-c ${man} '{0}' | ${sed} -e 's/\\x1B\\[[0-9;]*m//g; s/.\\x08//g' | ${bat} --language=man --plain --color=always";
      env.MANWIDTH = "80";
    };

    keybindings.enter = "actions:open";

    ui.preview_panel.header = "{0}";

    actions.open = {
      description = "Open the selected man page in the system pager";
      command = "${man} '{0}'";
      mode = "execute";
    };
  };
}
