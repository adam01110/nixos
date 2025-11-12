{
  osConfig,
  pkgs,
  ...
}:

# configure lutris and integrate with steam packages.
{
  config.programs.lutris = {
    enable = true;

    # add umu launcher for proton outside of steam.
    extraPackages = [ pkgs.umu-launcher ];

    # proton and the package of steam form the system steam module.
    steamPackage = osConfig.programs.steam.package;
    protonPackages = osConfig.programs.steam.extraCompatPackages;
  };
}
