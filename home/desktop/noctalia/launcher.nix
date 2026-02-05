{
  config,
  lib,
  pkgs,
  ...
}:
# Launcher behavior and default terminal command configuration.
let
  inherit (lib) getExe;
in {
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

  # Wtype for the automatic clipboard paste.
  home.packages = [pkgs.wtype];
}
