{...}: {
  imports = [
    ./dashboard.nix
    ./languages.nix
    ./settings.nix
    ./ui.nix
  ];

  programs.nvf = {
    enable = true;
    enableManpages = true;

    settings.vim = {
      withNodeJs = true;
      withPython3 = true;
      enableLuaLoader = true;
    };
  };

  stylix.targets.nvf.transparentBackground = true;
}
