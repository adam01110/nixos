{
  pkgs,
  ...
}:

{
  config.programs.lutris = {
    enable = true;

    #steamPackage = pkgs.steam-millennium;

    extraPackages = [ pkgs.umu-launcher ];

    protonPackages = [ pkgs.proton-ge-bin ];
  };
}
