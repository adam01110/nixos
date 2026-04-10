{
  # keep-sorted start
  config,
  lib,
  osConfig,
  # keep-sorted end
  ...
}: let
  inherit (lib) getExe;

  # keep-sorted start
  bat = getExe config.programs.bat.package;
  flatpak = getExe osConfig.services.flatpak.package;
  # keep-sorted end
in {
  programs.television.channels.flatpak = {
    # keep-sorted start block=yes newline_separated=yes
    actions = {
      # keep-sorted start block=yes newline_separated=yes
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
      # keep-sorted end
    };

    metadata = {
      name = "flatpak";
      description = "List and manage Flatpak applications";
      requirements = [
        # keep-sorted start
        "bat"
        "flatpak"
        # keep-sorted end
      ];
    };

    preview.command = "${flatpak} info --show-metadata '{split:\t:0}' 2>/dev/null | ${bat} --language=ini --style=plain --color=always";

    source = {
      # keep-sorted start
      command = "${flatpak} list --app --columns=application,name,version 2>/dev/null";
      display = "{split:\t:1} ({split:\t:2})";
      output = "{split:\t:0}";
      # keep-sorted end
    };
    # keep-sorted end
  };
}
