{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) getExe;
in {
  xdg.configFile."xdg-desktop-portal-termfilechooser/config".text = let
    terminalCommand = getExe config.xdg.terminal-exec.package;
  in ''
    [filechooser]
    cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
    env=TERMCMD=${terminalCommand} --title=Termfilechooser
  '';
}
