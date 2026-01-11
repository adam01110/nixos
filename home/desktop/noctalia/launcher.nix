{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) getExe;
in {
  # launcher behavior and default terminal command.
  programs.noctalia-shell.settings.appLauncher = {
    enableClipPreview = false;
    enableClipboardHistory = true;
    position = "center";
    sortByMostUsed = false;
    terminalCommand = getExe config.xdg.terminal-exec.package;
    useApp2Unit = true;
    showIconBackground = true;
    autoPasteClipboard = true;
  };

  home.packages = [pkgs.wtype];
}
