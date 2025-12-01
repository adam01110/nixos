{
  pkgs,
  ...
}:

{
  # miscellaneous cli helpers shared across hosts.
  # enable the nix-index-database integration with comma.
  programs.nix-index-database.comma.enable = true;

  # include sshfs for remote filesystem mounts without full fuse setup.
  environment.systemPackages = [ pkgs.sshfs ];
}
