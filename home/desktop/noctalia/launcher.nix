{
  config,
  lib,
  ...
}:

let
  inherit (lib) getExe;
in
{
  # launcher behavior and default terminal command.
  programs.noctalia-shell.settings.appLauncher = {
    enableClipboardHistory = true;
    position = "center";
    sortByMostUsed = false;
    terminalCommand = "${getExe config.programs.ghostty.package} -e";
    useApp2Unit = true;
  };
}
