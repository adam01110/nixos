{pkgs, ...}:
# Configure tlrc output formatting and package installation.
let
  tomlFormat = pkgs.formats.toml {};
in {
  xdg.configFile."tlrc/config.toml".source = tomlFormat.generate "tlrc-config.toml" {
    # Disable the auto updating cache.
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

      description.color = "white";

      bullet = {
        color = "green";
        bold = true;
      };
    };
  };

  home.packages = [pkgs.tlrc];
}
