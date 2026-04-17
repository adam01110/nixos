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

  fd = getExe config.programs.fd.package;
in {
  programs.television.channels.files = {
    # keep-sorted start block=yes newline_separated=yes
    actions.edit = {
      description = "Open file in editor";
      command = "$EDITOR '{0}'";
      mode = "execute";
    };

    metadata = {
      name = "files";
      description = "Browse files with type-aware previews";
      requirements = [
        # keep-sorted start
        "bat"
        "fd"
        "file"
        "hexyl"
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
      env.BAT_THEME = "ansi";
    };

    source.command = [
      "${fd} --type file --strip-cwd-prefix"
      "${fd} --type file --hidden --strip-cwd-prefix"
    ];
    # keep-sorted end
  };
}
