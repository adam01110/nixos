{
  config,
  pkgs,
  ...
}: let
  tomlFormat = pkgs.formats.toml {};
in {
  # Generate global rumdl settings with a shared cache path.
  xdg.configFile."rumdl/.rumdl.toml".source = tomlFormat.generate "rumdl-config.toml" {
    global.cache_dir = "${config.xdg.cacheHome}/rumdl";
  };
}
