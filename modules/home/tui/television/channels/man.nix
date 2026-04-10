{
  # keep-sorted start
  config,
  lib,
  pkgs,
  # keep-sorted end
  ...
}: let
  inherit (builtins) attrValues;
  inherit (lib) getExe;
  inherit (pkgs) writeShellApplication;

  man = getExe config.programs.man.package;
in {
  programs.television.channels.man = {
    # keep-sorted start block=yes newline_separated=yes
    actions.open = {
      description = "Open the selected man page in the system pager";
      command = "${man} '{0}'";
      mode = "execute";
    };

    keybindings.enter = "actions:open";

    metadata = {
      name = "man";
      description = "Browse and preview system manual pages";
      requirements = [
        # keep-sorted start
        "bat"
        "man"
        "sed"
        # keep-sorted end
      ];
    };

    preview = {
      command = "${getExe (writeShellApplication {
        name = "tv-man-preview";
        runtimeInputs =
          [config.programs.bat.package]
          ++ attrValues {
            inherit
              (pkgs)
              # keep-sorted start
              gnused
              man-db
              # keep-sorted end
              ;
          };
        text = ''
          MANPAGER=cat MANROFFOPT=-c man "$1" \
            | sed -e 's/\\x1B\\[[0-9;]*m//g; s/.\\x08//g' \
            | bat --language=man --plain --color=always
        '';
      })} '{0}'";
      env.MANWIDTH = "80";
    };

    source.command = "${man} -k .";

    ui.preview_panel.header = "{0}";
    # keep-sorted end
  };
}
