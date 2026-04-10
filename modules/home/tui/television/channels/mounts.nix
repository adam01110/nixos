{
  # keep-sorted start
  config,
  lib,
  pkgs,
  # keep-sorted end
  ...
}: let
  inherit
    (lib)
    # keep-sorted start
    getExe
    getExe'
    # keep-sorted end
    ;

  # keep-sorted start
  df = getExe' pkgs.coreutils "df";
  eza = getExe config.programs.eza.package;
  head = getExe' pkgs.coreutils "head";
  tail = getExe' pkgs.coreutils "tail";
  # keep-sorted end
in {
  programs.television.channels.mounts = {
    # keep-sorted start block=yes newline_separated=yes
    actions.cd = {
      description = "Open a shell in the selected mount point";
      command = "cd '{}' && $SHELL";
      mode = "execute";
    };

    keybindings.enter = "actions:cd";

    metadata = {
      name = "mounts";
      description = "List mounted filesystems";
      requirements = [
        # keep-sorted start
        "awk"
        "df"
        "eza"
        # keep-sorted end
      ];
    };

    preview.command = "${df} -h '{}' && echo && ${eza} -la '{}' 2>/dev/null | ${head} -20";

    source = {
      # keep-sorted start
      command = "${df} -h --output=target,fstype,size,used,avail,pcent 2>/dev/null | ${tail} -n +2";
      display = "{split: :0}";
      output = "{split: :0}";
      # keep-sorted end
    };
    # keep-sorted end
  };
}
