{
  config,
  lib,
  ...
}: let
  inherit
    (lib)
    escapeShellArgs
    getExe
    ;

  inherit
    (config.programs.eza)
    colors
    extraOptions
    icons
    package
    ;
in {
  programs.television.channels.zoxide = let
    zoxide = getExe config.programs.zoxide.package;
  in {
    metadata = {
      name = "zoxide";
      description = "Browse zoxide directory history";
      requirements = ["zoxide"];
    };

    source = {
      command = "${zoxide} query -l";
      no_sort = true;
      frecency = false;
    };

    preview.command = "${escapeShellArgs (
      ["${getExe package}"]
      ++ extraOptions
      ++ [
        "--color=${colors}"
        "--icons=${icons}"
      ]
    )} '{}'";

    keybindings = {
      enter = "actions:cd";
      ctrl-d = "actions:remove";
    };

    actions = {
      cd = {
        description = "Change to the selected directory";
        command = "cd '{}' && $SHELL";
        mode = "execute";
      };

      remove = {
        description = "Remove the selected directory from zoxide";
        command = "${zoxide} remove '{}'";
        mode = "fork";
      };
    };
  };
}
