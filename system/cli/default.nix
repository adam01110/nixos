{ ... }:

{
  imports = [ ./nh.nix ];

  # enable the nix-index-database integration with comma.
  programs.nix-index-database.comma.enable = true;
}
