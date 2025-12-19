{ ... }:

# assemble the Starship prompt configuration.
{
  # pull in per-feature Starship settings.
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

  # enable Starship for the user profile.
  programs.starship.enable = true;
}
