{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.zathura = {
    enable = true;

    options = {
      recolor = true;
      recolor-keephue = true;
      show-hidden = true;
    };
  };
}
