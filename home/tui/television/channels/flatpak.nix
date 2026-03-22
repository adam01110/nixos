{
  osConfig,
  lib,
  ...
}: let
  inherit (lib) getExe;
in {
  programs.television.channels.flatpak = let
    flatpak = getExe osConfig.services.flatpak.package;
  in {
    metadata = {
      name = "flatpak";
      description = "List and manage Flatpak applications";
      requirements = ["flatpak"];
    };

    source = {
      command = "${flatpak} list --app --columns=application,name,version 2>/dev/null";
      display = "{split:\t:1} ({split:\t:2})";
      output = "{split:\t:0}";
    };

    preview.command = "${flatpak} info '{split:\t:0}' 2>/dev/null";

    actions = {
      run = {
        description = "Launch the selected application";
        command = "${flatpak} run '{split:\t:0}'";
        mode = "execute";
      };

      uninstall = {
        description = "Uninstall the selected application";
        command = "${flatpak} uninstall '{split:\t:0}'";
        mode = "execute";
      };

      update = {
        description = "Update the selected application";
        command = "${flatpak} update '{split:\t:0}'";
        mode = "execute";
      };
    };
  };
}
