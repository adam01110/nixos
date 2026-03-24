{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) getExe getExe';

  man = getExe pkgs.man;
  batman = getExe pkgs.bat-extras.batman;
  apropos = getExe' pkgs.man "apropos";
in {
  programs.television.channels.man = {
    metadata = {
      name = "man";
      description = "Browse and preview system manual pages";
      requirements = [
        "apropos"
        "batman"
        "man"
      ];
    };

    source.command = "${apropos} .";

    preview = {
      command = "${batman} '{0}'";
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
