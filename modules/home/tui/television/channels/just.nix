{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) getExe;

  bat = getExe config.programs.bat.package;
  just = getExe pkgs.just;
in {
  programs.television.channels.just-recipes = {
    metadata = {
      name = "just";
      description = "Select and execute recipes from the local Justfile";
      requirements = [
        "just"
        "bat"
      ];
    };

    source.command = "${just} --summary | tr '[:blank:]' '\n' | sed '/^$/d'";

    preview.command = "${just} --show '{}' | ${bat} --language=Just --style=plain --color=always";

    keybindings.f5 = "actions:execute-recipe";

    actions.execute-recipe = {
      description = "Execute the selected Just recipe";
      command = "${just} '{}'";
      mode = "execute";
    };
  };
}
