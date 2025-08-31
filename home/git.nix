{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.git = {
    enable = true;
    lfs.enable = true;

    delta = {
      enable = true;

      options = {
        true-color = "always";
        line-numbers = true;
        side-by-side = true;

        hyperlinks = true;
        hyperlinks-file-link-format = "zed://file{path}:{line}";
      };
    };
  };
}
