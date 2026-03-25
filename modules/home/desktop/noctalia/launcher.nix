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
  programs.noctalia-shell = {
    settings.appLauncher = {
      enableClipboardHistory = true;
      position = "center";
      terminalCommand = getExe config.xdg.terminal-exec.package;
      useApp2Unit = true;
      showIconBackground = true;
      autoPasteClipboard = true;
      overviewLayer = true;
      density = "comfortable";
    };

    # Keep launcher runtime tools in the wrapped shell package path.
    packageOverrides.extraPackages = [pkgs.wtype];
  };
}
