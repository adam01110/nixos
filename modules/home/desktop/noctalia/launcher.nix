{
  # keep-sorted start
  config,
  lib,
  pkgs,
  # keep-sorted end
  ...
}: let
  inherit (lib) getExe;
in {
  programs.noctalia-shell = {
    # keep-sorted start block=yes newline_separated=yes
    # Keep launcher runtime tools in the wrapped shell package path.
    packageOverrides.extraPackages = [pkgs.wtype];

    settings.appLauncher = {
      # keep-sorted start
      autoPasteClipboard = true;
      density = "comfortable";
      enableClipboardHistory = true;
      overviewLayer = true;
      position = "center";
      showIconBackground = true;
      terminalCommand = getExe config.xdg.terminal-exec.package;
      useApp2Unit = true;
      # keep-sorted end
    };
    # keep-sorted end
  };
}
