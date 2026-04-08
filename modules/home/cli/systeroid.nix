{pkgs, ...}:
# Install `systeroid` and configure the application
let
  iniFormat = pkgs.formats.ini {};
in {
  home.packages = [pkgs.systeroid];

  # Generate systeroid settings.
  xdg.configFile."systeroid/systeroid.conf".source = iniFormat.generate {
    general.display_deprecated = true;
    cli.output_type = "tree";
  };
}
