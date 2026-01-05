{
  config,
  lib,
  ...
}:

let
  inherit (lib) getExe;
in
{
  # make thunar use the ghostty terminal.
  xdg.configFile."xfce4/helpers.rc".text =
    let
      ghostty = getExe config.programs.ghostty.package;
    in
    ''
      TerminalEmulator=${ghostty}
    '';
}
