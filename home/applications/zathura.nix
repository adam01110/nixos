{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.zathura = {
    enable = true;
    package = pkgs.zathura.override {
      plugins = with pkgs; [ zathura_pdf_mupdf ];
    };

    options = {
      recolor = true;
      recolor-keephue = true;
      show-hidden = true;
    };
  };
}
