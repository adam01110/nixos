{ ... }:

{
  imports = [
    ./profiles.nix
    ./settings.nix
  ];

  # enable zen browser.
  programs.zen-browser.enable = true;
}
