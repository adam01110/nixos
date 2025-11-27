{ ... }:

{
  imports = [
    ./profile.nix
    ./settings.nix
  ];

  # enable zen browser.
  programs.zen-browser.enable = true;
}
