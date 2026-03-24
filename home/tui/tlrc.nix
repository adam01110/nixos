{pkgs, ...}: let
  tomlFormat = pkgs.formats.toml {};
in {
  xdg.configFile."tlrc/config.toml".source = tomlFormat.generate "tlrc-config.toml" {
    cache.auto_update = false;

    output = {
      platform_title = true;

      show_hyphens = true;
      example_prefix = "◇ ";

      option_style = "both";
    };

    style = {
      title = {
        color = "magenta";
        underline = true;
      };

      bullet = {
        color = "green";
        bold = true;
      };
    };
  };

  home.packages = [pkgs.tlrc];
}
