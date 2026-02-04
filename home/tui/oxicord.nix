{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}:
# provide a styled oxicord wrapper.
let
  inherit
    (lib)
    getExe
    getExe'
    ;

  oxicordPkg = pkgs.oxicord;
  accentColor = "#${osConfig.lib.stylix.colors.base0B}";

  oxicord = pkgs.symlinkJoin {
    name = "oxicord-wrapped";
    paths = [oxicordPkg];
    nativeBuildInputs = [pkgs.makeWrapper];
    postBuild = ''
      wrapProgram $out/bin/oxicord \
        --add-flags "--group-guilds=true" \
        --add-flags "--accent-color=${accentColor}"
    '';
  };
in {
  home.packages = [oxicord];

  # create desktop entry to allow launching via launcher.
  xdg.desktopEntries.oxicord = {
    name = "Oxicord";
    genericName = "Terminal Discord Client";
    icon = "discord";
    exec = let
      terminalCommand = getExe config.xdg.terminal-exec.package;
      oxicordExe = getExe' oxicord "oxicord";
    in "${terminalCommand} --title=Oxicord ${oxicordExe}";
    categories = [
      "Network"
      "Chat"
      "Utility"
    ];
  };
}
