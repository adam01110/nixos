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
    enableClipPreview = false;
    enableClipboardHistory = true;
    position = "center";
    sortByMostUsed = false;
    terminalCommand = getExe config.xdg.terminal-exec.package;
    useApp2Unit = true;
  };
}
