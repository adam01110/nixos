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
in {
  programs.television.channels.text = {
    # keep-sorted start block=yes newline_separated=yes
    actions.edit = {
      description = "Open file in editor at line";
      command = "$EDITOR '+{strip_ansi|split:\\::1}' '{strip_ansi|split:\\::0}'";
      mode = "execute";
    };

    metadata = {
      name = "text";
      description = "A channel to find and select text from files";
      requirements = [
        # keep-sorted start
        "bat"
        "file"
        "hexyl"
        "rg"
        # keep-sorted end
      ];
    };

    preview = {
      command = "${getExe (writeShellApplication {
        name = "tv-text-preview";
        runtimeInputs =
          [config.programs.bat.package]
          ++ attrValues {
            inherit
              (pkgs)
              # keep-sorted start
              file
              hexyl
              # keep-sorted end
              ;
          };
        text = ''
          path="$1"
          mime_info=$(file --brief --mime --dereference -- "$path")

          if [ "''${mime_info##*charset=}" != "binary" ]; then
            bat -n --color=always -- "$path" || hexyl --border=none -- "$path"
          else
            hexyl --border=none -- "$path"
          fi
        '';
      })} '{strip_ansi|split:\\::0}'";
      offset = "{strip_ansi|split:\\::1}";
      env.BAT_THEME = "ansi";
    };

    source = {
      # keep-sorted start block=yes
      ansi = true;
      command = [
        "rg . --no-heading --line-number --colors 'match:fg:white' --colors 'path:fg:blue' --color=always"
        "rg . --no-heading --line-number --hidden --colors 'match:fg:white' --colors 'path:fg:blue' --color=always"
      ];
      output = "{strip_ansi|split:\\::..2}";
      # keep-sorted end
    };

    ui.preview_panel.header = "{strip_ansi|split:\\::..2}";
    # keep-sorted end
  };
}
