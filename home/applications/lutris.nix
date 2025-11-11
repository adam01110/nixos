{
  osConfig,
  pkgs,
  ...
}:

{
  config.programs.lutris = {
    enable = true;

    extraPackages = [ pkgs.umu-launcher ];

    steamPackage = osConfig.programs.steam.package;
    protonPackages = osConfig.programs.steam.extraCompatPackages;
  };
}
