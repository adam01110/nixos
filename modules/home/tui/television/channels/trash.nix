{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) getExe';

  echo = getExe' pkgs.coreutils "echo";
  trash-empty = getExe' pkgs.trash-cli "trash-empty";
  trash-list = getExe' pkgs.trash-cli "trash-list";
  trash-restore = getExe' pkgs.trash-cli "trash-restore";
in {
  programs.television.channels.trash = {
    metadata = {
      name = "trash";
      description = "Browse and restore trashed files";
      requirements = [
        "trash-empty"
        "trash-list"
        "trash-restore"
      ];
    };

    source = {
      command = "${trash-list} 2>/dev/null";
      no_sort = true;
      frecency = false;
    };

    preview.command = "${echo} '{}'";

    ui.preview_panel.size = 30;

    actions = {
      restore = {
        description = "Restore the selected trashed file";
        command = "${echo} '{split: :1..}' | ${trash-restore}";
        mode = "execute";
      };

      empty = {
        description = "Empty the entire trash";
        command = trash-empty;
        mode = "execute";
      };
    };
  };
}
