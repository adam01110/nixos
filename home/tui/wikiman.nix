{
  lib,
  pkgs,
  ...
}:

# configure wikiman.
let
  inherit (lib) getExe;

  pkg = pkgs.wikiman;
in
{
  # install wikiman package.
  home.packages = [ pkg ];

  # write basic wikiman configuration.
  xdg.configFile."wikiman/wikiman.conf".text = ''
    man_lang = en
  '';

  # create desktop entry to allow launching via launcher.
  xdg.desktopEntries.wikiman = {
    name = "Wikiman";
    genericName = "Documentation Browser";
    exec = getExe pkg;
    terminal = true;
    categories = [
      "Utility"
      "Documentation"
    ];
  };
}
