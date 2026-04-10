{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) getExe;

  # keep-sorted start
  bat = getExe config.programs.bat.package;
  just = getExe pkgs.just;
  # keep-sorted end
in {
  programs.television.channels.just-recipes = {
    # keep-sorted start block=yes newline_separated=yes
    actions.execute-recipe = {
      description = "Execute the selected Just recipe";
      command = "${just} '{}'";
      mode = "execute";
    };

    keybindings.f5 = "actions:execute-recipe";

    metadata = {
      name = "just";
      description = "Select and execute recipes from the local Justfile";
      requirements = [
        # keep-sorted start
        "bat"
        "just"
        # keep-sorted end
      ];
    };

    preview.command = "${just} --show '{}' | ${bat} --language=Just --style=plain --color=always";

    source.command = "${just} --summary | tr '[:blank:]' '\n' | sed '/^$/d'";
    # keep-sorted end
  };
}
