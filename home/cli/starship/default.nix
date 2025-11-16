{ ... }:

{
  imports = [
    ./build.nix
    ./container.nix
    ./disabled.nix
    ./format.nix
    ./general.nix
    ./git.nix
    ./languages.nix
    ./runtimes.nix
  ];

  programs.starship.enable = true;
}
