{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit
    (lib)
    getExe
    getExe'
    ;

  eza = getExe config.programs.eza.package;

  df = getExe' pkgs.coreutils "df";
  head = getExe' pkgs.coreutils "head";
  tail = getExe' pkgs.coreutils "tail";
in {
  programs.television.channels.mounts = {
    metadata = {
      name = "mounts";
      description = "List mounted filesystems";
      requirements = [
        "df"
        "awk"
        "eza"
      ];
    };

    source = {
      command = "${df} -h --output=target,fstype,size,used,avail,pcent 2>/dev/null | ${tail} -n +2";
      display = "{split: :0}";
      output = "{split: :0}";
    };

    preview.command = "${df} -h '{}' && echo && ${eza} -la '{}' 2>/dev/null | ${head} -20";

    keybindings.enter = "actions:cd";

    actions.cd = {
      description = "Open a shell in the selected mount point";
      command = "cd '{}' && $SHELL";
      mode = "execute";
    };
  };
}
