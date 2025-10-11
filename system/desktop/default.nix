{
  config,
  lib,
  pkgs,
  inputs,
  system,
  ...
}:

{
  imports = [
    ./hyprland.nix
    ./noctalia.nix
    ./stylix.nix
    ./xdg.nix
  ];

  environment.systemPackages = with pkgs; [ inputs.noctalia.packages.${system}.default ];
}
